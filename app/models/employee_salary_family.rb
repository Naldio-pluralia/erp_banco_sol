class EmployeeSalaryFamily < ApplicationRecord
  belongs_to :employee
  belongs_to :salary_family
  belongs_to :paygrade_change_reason
  has_many :salaries
  has_one :salary_grid, through: :salary_family
  validates_presence_of :employee, :salary_family, :paygrade_change_reason, :level, :paygrade, :since, :base_salary
  validates_uniqueness_of :since, scope: [:employee_id]
  validate :validates_dates

  def self.latest
    families_ids = EmployeeSalaryFamily.all.group_by(&:employee_id).map{|employee_id, families| families.sort_by{|f| f.since}.last.id}
    EmployeeSalaryFamily.where(id: families_ids)
  end

  # puts employee_number and level and his name
  def employee_name
    employee&.name
  end

  private
  def validates_dates
    # last_work_period =
    if self.since.present?
      # Error if start date greater the todays date
      if since > Date.current
        errors.add(:since, errors_t(:since, :before_or_todays_date))
      end
    end
    grid = salary_grid
    if base_salary.present? && grid.present?
      errors.add(:base_salary, errors_t(:base_salary, :less_than_or_equal_to, count: grid.kwanza_t(:value_125))) if base_salary >= grid.value_125
      errors.add(:base_salary, errors_t(:base_salary, :greater_than_or_equal_to, count: grid.kwanza_t(:value_80))) if base_salary < grid.value_80
    end
  end
end

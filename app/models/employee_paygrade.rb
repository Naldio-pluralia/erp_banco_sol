class EmployeePaygrade < ApplicationRecord
  belongs_to :employee, class_name: 'Employee'
  belongs_to :paygrade_change_reason
  has_many :salaries
  enum level: { a: 0, b: 1, c: 2, d: 3 }


  # puts employee level in upcase
  def present_level
    level.upcase
  end

  def present_until
    self.until.present? ? I18n.l(self.until) : I18n.t(:until_today)
  end

  # puts employee_number and level and his name
  def employee_and_paygarde
    "#{employee.number} (#{paygrade}-#{present_level}) #{employee.first_and_last_name}"
  end

  # get all employee_paygrades from all employee but only the last one of each employee
  def self.get_latest
    latest_ids = EmployeePaygrade.all.order(created_at: :asc).group_by(&:employee_id).map{|employee_id, employee_paygrades| employee_paygrades.last.id }
    where(id: latest_ids)
  end

  def self.get_active
    latest_ids = EmployeePaygrade.all.order(created_at: :asc).group_by(&:employee_id).map{|employee_id, employee_paygrades| employee_paygrades.last.id }
    where(employee_id: nil)
  end

  def not_valid?
    validates_paygrade_and_base_salary
    errors.present?
  end


  validates_presence_of :level, :paygrade, :since, :base_salary
  #validates_numericality_of :paygrade, greater_than_or_equal_to: 1, less_than_or_equal_to: 10
  validates_uniqueness_of :since, scope: [:employee_id]
  validates_uniqueness_of :until, scope: [:employee_id], if: ->(paygrade){paygrade.until.present?}
  validate :validates_dates, :validates_paygrade_and_base_salary

  private
  def validates_dates
    # last_work_period = 
    if self.since.present?
      # Error if start date greater the todays date
      if since > Date.current
        errors.add(:since, errors_t(:since, :before_or_todays_date))
      end
    end

    if self.until.present?
      # Error if finish date greater than today
      if self.until > Date.current
        errors.add(:until, errors_t(:until, :before_or_todays_date))
      end
    end

    if self.since.present? && self.until.present?
      # Error if since date bigger than until date
      if self.since > self.until
        errors.add(:since, errors_t(:since, :before_or_x_date, x: I18n.l(self.since)))
        errors.add(:until, errors_t(:until, :after_or_x_date, x: I18n.l(self.until)))
      end

      has_a_started_paygrade = EmployeePaygrade.where(employee_id: employee_id).where.not(id: id, until: nil).where(since: self.since..self.until).exists?
      has_a_finished_paygrade = EmployeePaygrade.where(employee_id: employee_id).where.not(id: id, until: nil).where(until: self.since..self.until).exists?
      
      # error if there is an employee_work_period between the start and finish date of this one
      if has_a_started_paygrade || has_a_finished_paygrade
        errors.add(:since, errors_t(:since, :divergent_dates, x: I18n.l(self.since)))
        errors.add(:until, errors_t(:until, :divergent_dates, x: I18n.l(self.until)))
      end
    end
  end
  
  # verifica se o paygrade existe na tabela Salaryboard e verifica se o salário condiz com o da mesma tabela
  def validates_paygrade_and_base_salary
    return unless base_salary.present?
    if paygrade.present?
      unless SalaryBoard.map_paygrades.include?(paygrade)
        errors.add(:paygrade, erros_t(:paygrade, :pick_an_avaliable_one))
      end
    end

    if base_salary.present? && paygrade.present? && level.present?
      salary_board_item = SalaryBoard.latest&.salary_board_items&.where(paygrade: paygrade)&.last
      if salary_board_item.present?
        value = salary_board_item.send("#{level}_value") rescue nil
        if value.present?
          errors.add(:base_salary, errors_t(:base_salary, :less_than, count: kwanza_t(value + salary_board_item.increment_value))) if base_salary >= (value + salary_board_item.increment_value)
          errors.add(:base_salary, errors_t(:base_salary, :greater_than_or_equal_to, count: kwanza_t(value))) if base_salary < value
        end
      end
    end
  end
end

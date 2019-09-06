class TaxSalary < ApplicationRecord
  belongs_to :salary
  belongs_to :tax_type
  # belongs_to :employee, class_name: 'Employee'

  after_save :update_salary_net_value
  after_destroy :update_salary_net_value

  def update_salary_net_value
    salary&.update_net_value
  end
end

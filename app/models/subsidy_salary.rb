class SubsidySalary < ApplicationRecord
  belongs_to :salary
  belongs_to :subsidy_type
  belongs_to :tax_type, optional: true
  #belongs_to :employee, class_name: 'Employee'

  # return the base subsidy value minus its taxed value
  def value
    base_value - taxed_value
  end

  before_create :add_taxes
  after_destroy :update_salary_net_value
  after_save :update_salary_net_value

  def add_taxes
    return unless subsidy_type.is_taxed
    tax = TaxType.get_by_code.wage_income.last
    self.tax_type_id = tax&.id
    return unless tax_type_id.present?
    self.taxed_value = tax.tax_value(base_value).round(2)
  end

  def update_salary_net_value
    salary&.update_net_value
  end
end

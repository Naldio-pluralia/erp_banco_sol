class SocialSecurityTax < TaxModel
  has_many :social_security_tax_salaries

  def self.latest
    all.order(created_at: :asc).last
  end

  def create_social_security_tax(salary)
    return unless active?
    SocialSecurityTaxSalary.create(salary_id: salary.id, social_security_tax_id: id, value: (salary.base_value * (percentage_from_employee/100)).round(2))
  end

  validates_numericality_of :percentage, greater_than: 0, less_than_or_equal_to: 100
  validates_numericality_of :percentage_from_employee, greater_than_or_equal_to: 0, less_than_or_equal_to: 100
  validates_numericality_of :percentage_from_employer, greater_than_or_equal_to: 0, less_than_or_equal_to: 100
  validate :validates_percentages

  private
  def validates_percentages
    unless (percentage_from_employee + percentage_from_employer) == percentage
      errors.add(:percentage, errors_t(:percentage, :the_sum_of_employee_percentage_end_employer_percentage_must_be_x, x: percentage_t(:percentage)))
    end
  end
end

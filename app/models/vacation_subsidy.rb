class VacationSubsidy < SubsidyModel
  has_many :vacation_subsidy_salaries

  def self.latest
    all.order(created_at: :asc).last
  end

  def create_vacation_subsidy(salary)
    return unless active?
    # permitir que seja criada vacation subsidy mesmo que não for o fim do ano
    return unless Time.now.month == 12
    VacationSubsidySalary.create(salary_id: salary.id, vacation_subsidy_id: id, value: (salary.base_value * (percentage/100)).round(2), year: Time.now.year - 1, percentage: 100)
  end

  validates_numericality_of :percentage, greater_than: 0, less_than_or_equal_to: 100
  # TODO , permitir que se tenha dois objectos vacation_subsidy_salary desde que a soma das suas percentagens não ultrapassem 100
  validates_presence_of :year
end

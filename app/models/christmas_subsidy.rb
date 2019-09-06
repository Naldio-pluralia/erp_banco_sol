class ChristmasSubsidy < SubsidyModel
  has_many :christmas_subsidy_salaries
  DEFAULT_NAME = 'christmas_subsidy_default_name'
  DEFAULT_ABBR_NAME = 'christmas_subsidy_default_abbr_name'

  def self.latest
    all.order(created_at: :asc).last
  end

  def create_christmas_subsidy(salary)
    return unless active?
    return unless Time.now.month == 12
    ChristmasSubsidySalary.create(salary_id: salary.id, christmas_subsidy_id: id, value: (salary.base_value * (percentage/100)).round(2), year: Time.now.year)
  end

  validates_numericality_of :percentage, greater_than: 0, less_than_or_equal_to: 100
  validates_presence_of :year
end

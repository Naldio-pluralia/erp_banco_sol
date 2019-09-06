class RemunerationSetting < ApplicationRecord

  def self.latest
    RemunerationSetting.order(id: :asc).last
  end

  validates_presence_of :base_salary, :update_factor, :day_to_process_salaries, :month_to_process_christmas_subsidy
  validates_numericality_of :base_salary, :day_to_process_salaries, :month_to_process_christmas_subsidy, :update_factor, greater_than: 0
  validates_numericality_of :day_to_process_salaries, less_than_or_equal_to: 31
  validates_numericality_of :month_to_process_christmas_subsidy, less_than_or_equal_to: 12
  # after_save :update_latest_salary_board

  # def update_latest_salary_board
  #   SalaryBoard.latest&.update_salary_board
  # end

end

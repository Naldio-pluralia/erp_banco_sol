class EmployeeRegime < ApplicationRecord
  belongs_to :employee, class_name: Employee.name
  enum regime: {five_two: 0, six_one: 1, twenty_eight: 2, three_shifts: 3, two_shifts: 4}
  validates_presence_of :enters_at, :leaves_at, if: -> (regime){regime.five_two? || regime.six_one?}
  validates_presence_of :employee_id
  validate :validates_time, if: -> (regime){regime.five_two? || regime.six_one?}

  def enters_at_time
    enters_at.present? ? enters_at.change(year: 2000, day: 1, month: 1) : nil
  end

  def leaves_at_time
    leaves_at.present? ? leaves_at.change(year: 2000, day: 1, month: 1) : nil
  end

  

  def validates_time
    return unless enters_at.present? && leaves_at.present?
    if enters_at_time >= leaves_at_time
      errors.add(:enters_at, errors_t(:enters_at, :before_x_date, x: I18n.l(self.leaves_at, format: '%H:%M')))
    end
  end
end

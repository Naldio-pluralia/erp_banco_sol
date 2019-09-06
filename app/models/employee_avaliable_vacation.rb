class EmployeeAvaliableVacation < ApplicationRecord
  belongs_to :employee
  has_many :vacation_days, dependent: :destroy
  validates_presence_of :year, :employee_id, :valid_from, :valid_until, :number_of_days
  validates_uniqueness_of :year, scope: :employee_id
  validates_numericality_of :number_of_days, greater_than: 0
  before_save :set_day_on_date

  # anos em que ainda tem férias disponíveis
  def self.with_vacations
    where(id: all.select{|f| f.number_of_days > f.vacation_days.pending_or_approved.size}.map(&:id))
  end

  def overdue?
    valid_until < Date.current
  end

  def not_overdue?
    not overdue?
  end

  def self.overdue
    where("valid_until < ?", Date.current)
  end

  def self.not_overdue
    where("valid_until >= ?", Date.current)
  end

  def self.with_vacations_not_overdue
    where("valid_until >= ?", Date.current).where(id: all.select{|f| f.number_of_days > f.vacation_days.pending_or_approved.size}.map(&:id))
  end

  def number_of_days_remaining
    number_of_days - vacation_days.pending_or_approved.size
  end

  def self.number_of_days_remaining
    sum{|f| f.number_of_days - f.vacation_days.pending_or_approved.size}
  end

  def valid_until
    super.present? ? super.change(day: super.end_of_month.day) : super
  end


  def set_day_on_date
    self.valid_until&.change(day: valid_until.end_of_month.day)
  end
end

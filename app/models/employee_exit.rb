class EmployeeExit < JustifiedRecord
  has_one :employee_justification, dependent: :destroy
  has_many :object_activities, as: :object, dependent: :destroy
  belongs_to :employee, class_name: Employee.name
  belongs_to :absence_type
  enum kind: {absent: 0, released: 1}
  validates_presence_of :date, :left_at, :returned_at, :kind
  validate :validate_time, on: :create
  before_validation :before_validation_set_number_of_hours_late, on: :create

  def name_and_date
    "(#{I18n.t('hours', count: number_of_hours_absent)}) (#{absence_type.enum_t(:kind)}) #{absence_type.name} #{I18n.l(date)} #{I18n.l(left_at, format: '%H:%M')} - #{I18n.l(returned_at, format: '%H:%M')}"
  end

  def notification_exit_message
    "O colaborador #{self.employee.number} - #{self.employee.first_and_last_name} saiu por #{name_and_date}"
  end

  def self.unjustified
    all_ids = all.map{|e| e.id if e.employee_justification.nil?}.flatten.compact.uniq
    where(id: all_ids)
  end

  def exit_inside_regime?(regime)
    return true if !regime.five_two? && !regime.six_one?
    return false if left_at.nil? || returned_at.nil?
    enters_at_time = regime.enters_at.change(day: 1, month: 1, year: 2000)
    leaves_at_time = regime.leaves_at.change(day: 1, month: 1, year: 2000)
    left_at_time = left_at.change(day: 1, month: 1, year: 2000)
    returned_at_time = returned_at.change(day: 1, month: 1, year: 2000)
    enters_at_time <= left_at_time && returned_at_time <= leaves_at_time
  end

  def before_validation_set_number_of_hours_late
    last_regime = employee.employee_regimes.order(created_at: :asc).last
    return unless last_regime.present? && (last_regime.five_two? || last_regime.six_one?)
    if left_at.present? && returned_at.present?
      left_at_time = left_at.change(day: 1, month: 1, year: 2000)
      returned_at_time = returned_at.change(day: 1, month: 1, year: 2000)
      self.number_of_hours_absent = ((returned_at_time.to_time - left_at_time.to_time)/1.hours).ceil
    end
  end

  def validate_time
    return if employee_id.nil?
    last_regime = employee.employee_regimes.order(created_at: :asc).last
    if last_regime.nil?
      errors.add(:arrived_at, errors_t(:arrived_at, :configure_employee_x_regime_first, x: employee.name_and_number))
      return
    end

    if self.left_at.present? && self.returned_at.present?
      return unless last_regime.five_two? || last_regime.six_one?
      left_at_time = left_at.change(day: 1, month: 1, year: 2000)
      returned_at_time = returned_at.change(day: 1, month: 1, year: 2000)
      if left_at_time > returned_at_time
        errors.add(:left_at, errors_t(:left_at, :before_x_date, x: I18n.l(self.returned_at, format: '%H:%M')))
        return
      end
    end

    unless exit_inside_regime?(last_regime)
      errors.add(:left_at, errors_t(:left_at, :check_the_time_employee_works_from_x_to_y, x: I18n.l(last_regime.enters_at, format: '%H:%M'), y: I18n.l(last_regime.leaves_at, format: '%H:%M')))
      return
    else

      # delays = employee.employee_delays.select{|a| days.includes?(a.arrived_at.to_date)}
      # absences = employee.employee_absences.select{|a| a.days.intersects?(days)}
      # exists = employee.employee_exits.select{|a| days.includes?(a.date)}

    end

  end

  def validates_conflict
    return if employee_id.nil? || date.nil?
    if employee.has_absences_on?(date) || employee.has_delays_on?(date) || employee.has_exits_on?(date, id) || employee.has_vacations_on?(date) || employee.has_presences_on?(date)
      errors.add(:date, "Já tem registo nesta data")
    end
  end
end

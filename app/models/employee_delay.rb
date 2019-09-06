class EmployeeDelay < JustifiedRecord
  has_one :employee_justification, dependent: :destroy
  has_many :object_activities, as: :object, dependent: :destroy
  belongs_to :employee, class_name: Employee.name
  belongs_to :absence_type
  validates_presence_of :arrived_at, :number_of_hours_late
  validate :validate_time, on: :create
  validate :validates_conflict
  before_validation :before_validation_set_number_of_hours_late, on: :create
  validate :check_for_tolerance


  def name_and_date
    "(#{I18n.t('hours', count: number_of_hours_late)}) (#{absence_type.enum_t(:kind)}) #{absence_type.name} #{I18n.l(arrived_at, format: '%d/%b/%Y %H:%M')}"
  end

  def notification_delay_message
    "Foi registado o atraso do colaborador #{self.employee.number} - #{self.employee.first_and_last_name}"
  end

  def self.unjustified
    all_ids = all.map{|e| e.id if e.employee_justification.nil?}.flatten.compact.uniq
    where(id: all_ids)
  end

  def delay_inside_regime?(regime)
    return true if !regime.five_two? && !regime.six_one?
    enters_at_time = regime.enters_at.change(day: 1, month: 1, year: 2000)
    leaves_at_time = regime.leaves_at.change(day: 1, month: 1, year: 2000)
    arrived_at_time = arrived_at.change(day: 1, month: 1, year: 2000)
    enters_at_time <= arrived_at_time && arrived_at_time <= leaves_at_time
  end

  def before_validation_set_number_of_hours_late
    last_regime = employee.employee_regimes.order(created_at: :asc).last
    return if last_regime.nil? || (!last_regime.five_two? && !last_regime.six_one?)
    if last_regime.present? && arrived_at.present?
      enters_at_time = last_regime.enters_at.change(day: 1, month: 1, year: 2000)
      leaves_at_time = last_regime.leaves_at.change(day: 1, month: 1, year: 2000)
      arrived_at_time = arrived_at.change(day: 1, month: 1, year: 2000)
      self.number_of_hours_late = ((arrived_at_time.to_time - last_regime.enters_at_time.to_time)/1.hours).ceil
    end
  end

  def validate_time
    return if employee_id.nil?
    last_regime = employee.employee_regimes.order(created_at: :asc).last
    if last_regime.nil?
      errors.add(:arrived_at, errors_t(:arrived_at, :configure_employee_x_regime_first, x: employee.name_and_number))
      return
    end

    unless delay_inside_regime?(last_regime)
      errors.add(:arrived_at, errors_t(:arrived_at, :check_the_time_employee_works_from_x_to_y, x: I18n.l(last_regime.enters_at, format: '%H:%M'), y: I18n.l(last_regime.leaves_at, format: '%H:%M')))
      return
    else

      # delays = employee.employee_delays.select{|a| days.includes?(a.arrived_at.to_date)}
      # absences = employee.employee_absences.select{|a| a.days.intersects?(days)}
      # exists = employee.employee_exits.select{|a| days.includes?(a.date)}

    end

  end

  def validates_conflict
    return if employee_id.nil? || arrived_at.nil?
    if employee.has_absences_on?(arrived_at) || employee.has_delays_on?(arrived_at, id) || employee.has_exits_on?(arrived_at) || employee.has_vacations_on?(arrived_at) || employee.has_presences_on?(arrived_at)
      errors.add(:arrived_at, "Já tem registo nesta data")
    end
  end

  # verifica o tempo da tolerancia
  def check_for_tolerance
    regime = self.employee.employee_regimes.order(:created_at).last
    return unless regime.present?
    if (regime.enters_at + self.employee.tolerance.minutes).to_string('%H%M').to_i > arrived_at.to_string('%H%M').to_i
      errors.add(:arrived_at,  'Ainda está dentro do tempo de tolerância')
    end
  end
end

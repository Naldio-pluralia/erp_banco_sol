class EmployeeAbsence < JustifiedRecord
  has_one :employee_justification, dependent: :destroy
  has_many :object_activities, as: :object, dependent: :destroy
  has_many :absence_days, dependent: :destroy
  belongs_to :employee, class_name: Employee.name
  belongs_to :absence_type
  validates_presence_of :employee_id, :absence_type_id, :returned_at, :left_at
  # validates_numericality_of :absent_days_number, greater_than: 0
  validate :validate_time, on: :create
  validate :validate_conflict
  before_validation :bf_build_absence_days

  after_create :notification_on_after_create
  # number of hours
  def hours
    days * 8
  end

  def name_and_date
    "(#{I18n.t('days', count: absent_days_number)}) (#{absence_type&.enum_t(:kind)}) #{absence_type&.name} #{I18n.l(left_at)} - #{I18n.l(returned_at)}"
  end

  def notification_absence_message
    "O colaborador #{self.employee.number} - #{self.employee.first_and_last_name} faltou, #{name_and_date}"
  end

  def self.unjustified
    all_ids = all.map{|e| e.id if e.employee_justification.nil?}.flatten.compact.uniq
    where(id: all_ids)
  end

  def days
    absence_days.map(&:date)
  end

  def absent_days_number
    days.size
  end

  def bf_build_absence_days
    return unless employee_id.present?
    last_regime = employee.employee_regimes.order(created_at: :asc).last
    return if last_regime.nil?
    absence_days.build((self.left_at...self.returned_at).to_a.map{|d| {date: d} unless (last_regime.five_two? && d.weekend?) || (last_regime.six_one? && d.sunday?)}.compact) if left_at.present? && returned_at.present?
    # last_regime = employee.employee_regimes.order(created_at: :asc).last
    # if last_regime.present? && left_at.present? && returned_at.present?
    #   if last_regime.five_two?
    #     self.absent_days_number = ((self.left_at...self.returned_at).to_a.map{|d| d.to_date unless d.sunday? || d.saturday? }.compact(&:to_date) - DateType.all.map{|d| d.date.to_date}).size
    #   elsif last_regime.six_one?
    #     self.absent_days_number = ((self.left_at...self.returned_at).to_a.map{|d| d.to_date unless d.sunday? }.compact(&:to_date) - DateType.all.map{|d| d.date.to_date}).size
    #   end
    # end
  end

  def validate_time
    return if employee_id.nil?
    last_regime = employee.employee_regimes.order(created_at: :asc).last
    if last_regime.nil?
      errors.add(:left_at, errors_t(:left_at, :configure_employee_x_regime_first, x: employee.name_and_number))
      return
    end
  end

  def validate_conflict
    if returned_at.present? && left_at.present? && employee_id.present?
      dates = (self.left_at...self.returned_at).to_a
      empl = employee
      if returned_at <= left_at
        errors.add(:left_at, "Deve ser anterior a 1º dia de Presença (Regresso)")
      elsif empl.has_absences_on?(dates, id) || empl.has_delays_on?(dates) || empl.has_exits_on?(dates) || empl.has_vacations_on?(dates) || empl.has_presences_on?(dates)
        errors.add(:left_at, "Já tem registo nesta data")
      end
    end
  end

  def self.create_todays_system_absences(other_day = Date.current)
    p "Criando Employee Absence"
    system_absence_type = AbsenceType.latests.system_absences.last
    return EmployeeAbsence.create([]) if system_absence_type.nil?
    data = Employee.all.map{|f| {employee_id: f.id, absence_type_id: system_absence_type.id, left_at: other_day, returned_at: other_day + 1.day} }
    EmployeeAbsence.create(data) do |employee_absence|
      p "Criando Employee Absence"
      p employee_absence
    end
  end

  def notification_on_after_create
    supervisor = self&.employee&.efective_position&.position&.efective
    if supervisor.present?
      Notification.new_notification(self.notification_absence_message, supervisor, "/#")
    end
  end

end

class EmployeePresence < EmployeeAttendanceRecord
  belongs_to :employee
  has_many :object_activities, as: :object, dependent: :destroy
  enum status: {unconfirmed: 0, confirmed: 1}
  validates_presence_of :employee_id, :status, :date
  validates_uniqueness_of :date, scope: :employee_id
  validate :validate_presence_date, :check_for_tolerance

  def validate_presence_date
    return unless employee_id.present? && date.present?
    empl = employee
    if empl.has_absences_on?(date)
      errors.add(:date, "1")
    end
    if empl.has_delays_on?(date)
      errors.add(:date, "2")
    end
    if empl.has_exits_on?(date)
      errors.add(:date, "3")
    end
    if empl.has_vacations_on?(date)
      errors.add(:date, "4")
    end
  end

  def set_status
    if self.automatic_approve? || self.employee.efective_position&.position.present?
      self.status = :confirmed
    end
  end


  # verifica o tempo da tolerancia
  def check_for_tolerance
    regime = self.employee.employee_regimes.order(:created_at).last
    return if regime.nil?
    if (regime.enters_at + self.employee.tolerance.minutes).to_string('%H%M').to_i > DateTime.current.to_string('%H%M').to_i
      errors.add(:date,  'Ainda está dentro do tempo de tolerância')
    end
  end
end

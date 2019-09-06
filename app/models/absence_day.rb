class AbsenceDay < ApplicationRecord
  belongs_to :employee_absence
  validates_presence_of :date, :employee_absence
  validates_uniqueness_of :date, scope: :employee_absence_id
  validate :validates_holiday

  def validates_holiday
    last_regime = employee_absence.employee.employee_regimes.order(created_at: :asc).last
    if last_regime.present?
      if last_regime.five_two? && date.weekend?
        errors.add(:date, 'Não se trabalha neste dia')
      elsif last_regime.six_one? && date.sunday?
        errors.add(:date, 'Não se trabalha neste dia')
      end
    end
    errors.add(:date, 'Não se trabalha neste dia') if DateType.where(date: date).exists?
    ea = employee_absence
    errors.add(:date, 'Este dia não foi seleccionado') unless (ea.left_at...ea.returned_at).include?(date)
    employee_id = employee_absence.employee_id
    errors.add(:date, 'Já tem um registo sobre esta data') if (EmployeeVacation.where(employee_id: employee_id).includes(:vacation_days).map{|f| f.vacation_days.map(&:date)} + EmployeeExit.where(employee_id: employee_id).map(&:date) + EmployeeDelay.where(employee_id: employee_id).map{|f| f.arrived_at.to_date} ).include?(date)
  end
end

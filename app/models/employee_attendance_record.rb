class EmployeeAttendanceRecord < ApplicationRecord
  self.abstract_class = true

  # verificar se não é preciso que o supervisor para aprovar a marcação
  def automatic_approve?
    case self.class&.name
      when 'EmployeeExit'
        self.employee&.groups&.active&.t_exit.present?     || self.employee&.efective_position&.groups&.active&.t_exit.present?     || self.employee&.efective_position&.function&.groups&.active&.t_exit.present?
      when 'EmployeeDelay'
        self.employee&.groups&.active&.t_delay.present?    || self.employee&.efective_position&.groups&.active&.t_delay.present?    || self.employee&.efective_position&.function&.groups&.active&.t_delay.present?
      when 'EmployeePresence'
        self.employee&.groups&.active&.t_presence.present? || self.employee&.efective_position&.groups&.active&.t_presence.present? || self.employee&.efective_position&.function&.groups&.active&.t_presence.present?
      when 'EmployeeAbsence'
        self.employee&.groups&.active&.t_absence.present?  || self.employee&.efective_position&.groups&.active&.t_absence.present?  || self.employee&.efective_position&.function&.groups&.active&.t_absence.present?
      when 'EmployeeVacation'
        self.employee&.groups&.active&.t_vacation.present? || self.employee&.efective_position&.groups&.active&.t_vacation.present? || self.employee&.efective_position&.function&.groups&.active&.t_vacation.present?
      else
        false
    end
  end

end

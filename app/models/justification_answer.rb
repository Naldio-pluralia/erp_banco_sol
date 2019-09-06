class JustificationAnswer < ApplicationRecord
  belongs_to :employee_justification
  belongs_to :employee, class_name: Employee.name, optional: true
  enum status: {pending: 0, approved: 1, not_approved: 2}
  enum kind: {supervisor: 0, supervisor_supervisor: 1, dpe_employee: 2, dpe_supervisor: 3}
  validates_presence_of :employee_justification_id, :status, :kind
  validates_presence_of :employee_id, if: -> (f){f.supervisor? || f.supervisor_supervisor?}
  validates_uniqueness_of :kind, scope: [:employee_justification_id], on: :create
  validates_uniqueness_of :employee_id, scope: [:employee_justification_id], if: :employee_id_present?

  def notification_justification_answer_message
    if self&.employee_justification&.employee_absence_id.present?
      "#{self&.employee_justification&.employee&.number} - #{self&.employee_justification&.employee&.first_and_last_name}, O justificativo da ausência (#{self&.employee_justification&.employee_absence.name_and_date}) foi verificado para #{self.status.pt} "
    elsif self&.employee_justification&.employee_delay_id.present?
      "#{self&.employee_justification&.employee&.number} - #{self&.employee_justification&.employee&.first_and_last_name}, O justificativo do atraso (#{self&.employee_justification&.employee_delay.name_and_date}) foi verificado para #{self.status.pt} "
    elsif self&.employee_justification&.employee_exit_id.present?
      "#{self&.employee_justification&.employee&.number} - #{self&.employee_justification&.employee&.first_and_last_name}, O justificativo da saída (#{self&.employee_justification&.employee_exit.name_and_date}) foi verificado para #{self.status.pt} "
    end
  end

  def employee_id_present?
    employee_id.present?
  end
end

class ObjectResponse < ApplicationRecord
  belongs_to :employee, optional: true
  belongs_to :object, polymorphic: true

  enum status: {pending: 0, approved: 1, not_approved: 2}
  enum kind: {supervisor: 0, supervisor_supervisor: 1, dpe_employee: 2, dpe_supervisor: 3}

  validates_presence_of :object_id, :object_type, :status, :kind
  validates_presence_of :employee_id, if: -> (f){f.supervisor? || f.supervisor_supervisor?}
  validates_uniqueness_of :employee_id, scope: [:object_id, :object_type], if: -> (f){f.employee_id.present?}
  validates_uniqueness_of :kind, scope: [:object_id, :object_type]

  def message_for_approve_notification_approve
    proprietadio = self&.object&.employee&.first_and_last_name
    "Caro colaborador #{proprietadio} o seu pedido foi aprovado por #{employee.first_and_last_name}."
  end

  def message_for_approve_notification_disaprove
    proprietadio = self&.object&.employee&.first_and_last_name
    "Caro colaborador #{proprietadio} o seu pedido foi reprovado por #{employee.first_and_last_name}."
  end

  def send_notification_approve
    employee_request = self&.object&.employee
    Notification.new_notification(self&.message_for_approve_notification_approve, employee_request, "/#{self&.object_type&.underscore&.pluralize}/#{self.object_id}") if employee_request.present?
  end

  def send_notification_disaprove
    employee_request = self&.object&.employee
    Notification.new_notification(self.message_for_approve_notification_disaprove, employee_request, "/#{self&.object_type&.underscore&.pluralize}/#{self.object_id}") if employee_request.present?
  end

  def self.status
    all_status = all.map(&:status).uniq
    if all_status.size == 1
      all_status.last
    else
      'pending'
    end
  end

  # can_respond?(employee, 'approved', 'supervisor', [object_responses])
  # required_permissions = ['supervisor', 'supervisor_supervisor', 'dpe_employee', 'dpe_supervisor']
  def self.can_respond?(current, employee, status, kind, required_permissions, existing_responses, dpe_employees, dpe_supervisors)
    return false if existing_responses.select{|response| response.status == status && response.kind == kind && response.employee_id == current.employee&.id}.last.present?
    if 'supervisor'.eql?(kind)
      return false unless required_permissions.include?('supervisor') && current.team_members.ids.include?(employee.id)

    elsif 'supervisor_supervisor'.eql?(kind)
      return false unless required_permissions.include?('supervisor_supervisor') && current.team_team_members.ids.include?(employee.id)

    elsif 'dpe_employee'.eql?(kind)
      return false if !required_permissions.include?('dpe_employee') || !dpe_employees.map(&:id).include?(current.employee&.id) || (current.team_members.ids.include?(employee.id) && required_permissions.include?('supervisor')) || (current.team_team_members.ids.include?(employee.id) && required_permissions.include?('supervisor_supervisor'))

    elsif 'dpe_supervisor'.eql?(kind)
      return false if !required_permissions.include?('dpe_supervisor') || !dpe_supervisors.map(&:id).include?(current.employee&.id) || (current.team_members.ids.include?(employee.id) && required_permissions.include?('supervisor')) || (current.team_team_members.ids.include?(employee.id) && required_permissions.include?('supervisor_supervisor'))

    end

  end
end

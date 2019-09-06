class EmployeeRequest < ApplicationRecord
  belongs_to :employee
  belongs_to :request_type
  has_many :object_approvers, through: :request_type
  has_many :object_attachments, as: :object, dependent: :destroy
  has_many :object_responses, as: :object, dependent: :destroy
  has_many :object_activities, as: :object, dependent: :destroy
  enum status: {draft: 0, pending: 1, approved: 2, not_approved: 3}
  mount_uploaders :virtual_object_attachments, AttachmentsUploader
  after_create :create_responses
  after_create :create_notifications

  def message_for_notification
    "O colaborador #{self&.employee&.first_and_last_name } criou um pedido do tipo - #{self&.request_type&.name}"
  end
  def create_responses
    type = request_type
    colaborator = employee

    if type.requires_supervisor_approval
      p ObjectResponse.create(object: self, kind: 'supervisor', employee_id: colaborator&.efective_position&.position&.efective_id)
    end
    if type.requires_supervisor_supervisor_approval
      p ObjectResponse.create(object: self, kind: 'supervisor_supervisor', employee_id: colaborator&.efective_position&.position&.position&.efective_id)
    end
    if type.requires_dpe_approval
      p ObjectResponse.create(object: self, kind: 'dpe_employee')
    end
    if type.requires_dpe_supervisor_approval
      p ObjectResponse.create(object: self, kind: 'dpe_supervisor')
    end
  end

  def create_notifications
    #return unless approvers.present?
    approvers = self.object_approvers&.where(kind: [:dpe_employee, :dpe_supervisor])&.map(&:employee_id)
    approvers += self.object_responses&.where(kind: [:supervisor, :supervisor_supervisor])&.map(&:employee_id).uniq

    Employee.where(id: approvers).each do |employee|
      Notification.new_notification(self.message_for_notification, employee, "/employee_requests/#{self.id}")
    end
  end
end

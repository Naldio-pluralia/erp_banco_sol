class RequestType < ApplicationRecord
  has_many :object_attachments, as: :object, dependent: :destroy
  has_many :object_approvers, as: :object, dependent: :destroy
  has_many :employee_requests, dependent: :destroy
  validates_presence_of :name, :note
  validate :validate_approvals
  mount_uploaders :virtual_object_attachments, AttachmentsUploader

  def validate_approvals
    if requires_supervisor_approval.blank? && requires_supervisor_supervisor_approval.blank? && requires_dpe_approval.blank? && requires_dpe_supervisor_approval.blank?
      errors.add(:requires_supervisor_approval, 'Marque pelo menos uma aprovação')
      errors.add(:requires_supervisor_supervisor_approval, 'Marque pelo menos uma aprovação')
      errors.add(:requires_dpe_approval, 'Marque pelo menos uma aprovação')
      errors.add(:requires_dpe_supervisor_approval, 'Marque pelo menos uma aprovação')

    end
  end

  def required_approvals
    r = []
    r << 'supervisor' if requires_supervisor_approval
    r << 'supervisor_supervisor' if requires_supervisor_supervisor_approval
    r << 'dpe_employee' if requires_dpe_approval
    r << 'dpe_supervisor' if requires_dpe_supervisor_approval
    r
  end
end

class Appliance < ApplicationRecord
  enum relevance: {unset: 0, irrelevant: 1, relevant: 2}
  validates_presence_of :name, :email, :cellphone, :note, :resume
  mount_uploader :resume, AttachmentUploader
  mount_uploader :attachments, AttachmentsUploader
end

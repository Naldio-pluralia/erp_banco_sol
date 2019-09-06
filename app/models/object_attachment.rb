class ObjectAttachment < ApplicationRecord
  belongs_to :object, polymorphic: true
  mount_uploader :file, FileUploader
  validates_integrity_of :file
  validates_processing_of :file
  # validate :validates_integrity

  # def validates_integrity
  #   unless extension_whitelist.include?(file.to_s.split('.').last.downcase)
  #     p file.to_s.split('.').last.downcase
  #     errors.add(:file, errors_t(:file, :whitelist_error, x: extension_whitelist.join(',')))
  #   end
  # end
end

class ObjectVideo < ApplicationRecord
  belongs_to :object, polymorphic: true
  # file_processing attribute is managed by carrierwave_backgrounder
  # it contains an indicator of uploaded file state: being processed or not
  mount_uploader :local_file, ::VideoUploader, mount_on: :local_file
  #process_in_background :local_file
  store_in_background :local_file
  mount_uploader :local_watermark_image, FileUploader, mount_on: :local_watermark_image
  validates_presence_of :local_file
  enum kind: {local: 0, youtube: 1}
end

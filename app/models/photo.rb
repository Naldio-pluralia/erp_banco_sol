class Photo < ApplicationRecord
  # include ImageUploader[:image]
  mount_uploader :image, AttachmentUploader

  def image_path
    image.path
  end
end

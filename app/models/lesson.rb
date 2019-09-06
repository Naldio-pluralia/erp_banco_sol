class Lesson < ApplicationRecord
  belongs_to :chapter
  has_one :course, through: :chapter
  has_many :object_attachments, as: :object, dependent: :destroy
  enum video_kind: {local: 0, youtube: 1}
  validates_presence_of :name, :number
  validates :local_video, file_size: { less_than_or_equal_to: 500.megabytes },
                     file_content_type: { allow: [/^video\/.*/] }
  validates_uniqueness_of :number, scope: [:chapter_id]
  mount_uploader :local_video, LocalVideoUploader
end

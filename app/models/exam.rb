class Exam < ApplicationRecord
  belongs_to :chapter
  has_one :course, through: :chapter
  has_many :questions, dependent: :destroy
  validates_uniqueness_of :chapter_id

end

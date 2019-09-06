class Chapter < ApplicationRecord
  belongs_to :course
  has_many :lessons, dependent: :destroy
  has_one :exam, dependent: :destroy
  validates_presence_of :number
  validates_uniqueness_of :number, scope: [:course_id]

end

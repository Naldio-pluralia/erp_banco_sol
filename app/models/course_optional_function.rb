class CourseOptionalFunction < ApplicationRecord
  belongs_to :course
  belongs_to :function
  validates_presence_of :course_id, :function_id
  validates_uniqueness_of :course_id, scope: [:function_id]
end

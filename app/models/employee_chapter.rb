class EmployeeChapter < ApplicationRecord
  belongs_to :employee_course
  belongs_to :chapter
  has_many :employee_lessons, dependent: :destroy
  has_one :employee_exam, dependent: :destroy
end

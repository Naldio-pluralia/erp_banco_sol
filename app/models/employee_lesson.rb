class EmployeeLesson < ApplicationRecord
  belongs_to :lesson
  belongs_to :employee_chapter
  enum status: {not_done: 0, done: 1}
end

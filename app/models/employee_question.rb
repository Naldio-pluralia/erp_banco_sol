class EmployeeQuestion < ApplicationRecord
  belongs_to :employee_exam
  belongs_to :question
  has_one :employee_answer, dependent: :destroy
  has_many :employee_question_options, dependent: :destroy
  enum status: {not_done: 0, done: 1}
end

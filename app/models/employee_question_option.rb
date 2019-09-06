class EmployeeQuestionOption < ApplicationRecord
  belongs_to :question_option
  belongs_to :employee_question
  enum status: {not_selected: 0, selected: 1}
end

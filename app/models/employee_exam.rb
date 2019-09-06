class EmployeeExam < ApplicationRecord
  belongs_to :exam
  belongs_to :employee_chapter
  has_many :employee_questions, dependent: :destroy
  has_many :employee_answers, through: :employee_questions
  has_many :employee_question_options, through: :employee_questions 
  enum status: {not_done: 0, done: 1}
  
  def update_status()
    update_columns(status: employee_questions.map(&:status).uniq.sort.last || :not_done)  
  end
end

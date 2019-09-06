class RemoveEmployeeCourseFromSeveralCourseRelateResources < ActiveRecord::Migration[5.1]
  def change
    remove_reference :employee_lessons, :employee_course, foreign_key: true
    remove_reference :employee_exams, :employee_course, foreign_key: true
    remove_reference :employee_questions, :employee_course, foreign_key: true
    remove_reference :employee_question_options, :employee_course, foreign_key: true
    remove_reference :employee_answers, :employee_course, foreign_key: true
    remove_reference :employee_answers, :question, foreign_key: true
    add_reference :employee_answers, :employee_question, foreign_key: true
    add_reference :employee_question_options, :employee_question, foreign_key: true
  end
end

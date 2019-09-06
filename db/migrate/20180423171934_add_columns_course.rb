class AddColumnsCourse < ActiveRecord::Migration[5.1]
  def change
    add_column :employee_lessons, :status, :integer, default: 0, null: false
    add_column :employee_exams, :status, :integer, default: 0, null: false
    add_column :employee_question_options, :status, :integer, default: 0, null: false
    add_column :employee_answers, :status, :integer, default: 0, null: false 
  end
end

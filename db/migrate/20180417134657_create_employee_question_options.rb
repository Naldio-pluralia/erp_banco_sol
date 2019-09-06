class CreateEmployeeQuestionOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :employee_question_options do |t|
      t.references :question_option, foreign_key: true
      t.references :employee_course, foreign_key: true

      t.timestamps
    end
  end
end

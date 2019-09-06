class CreateEmployeeQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :employee_questions do |t|
      t.references :employee_course, foreign_key: true
      t.references :employee_exam, foreign_key: true
      t.references :question, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end

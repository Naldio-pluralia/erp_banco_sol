class CreateEmployeeAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :employee_answers do |t|
      t.references :question, foreign_key: true
      t.text :answer
      t.boolean :option, null: false, default: false
      t.references :employee_course, foreign_key: true

      t.timestamps
    end
  end
end

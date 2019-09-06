class CreateEmployeeExams < ActiveRecord::Migration[5.1]
  def change
    create_table :employee_exams do |t|
      t.references :exam, foreign_key: true
      t.references :employee_course, foreign_key: true

      t.timestamps
    end
  end
end

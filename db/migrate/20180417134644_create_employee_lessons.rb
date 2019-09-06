class CreateEmployeeLessons < ActiveRecord::Migration[5.1]
  def change
    create_table :employee_lessons do |t|
      t.references :lesson, foreign_key: true
      t.references :employee_course, foreign_key: true

      t.timestamps
    end
  end
end

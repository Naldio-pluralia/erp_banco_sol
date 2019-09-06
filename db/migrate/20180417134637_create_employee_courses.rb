class CreateEmployeeCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :employee_courses do |t|
      t.references :employee, foreign_key: {to_table: :next_sgad_employees}
      t.references :course, foreign_key: true
      t.datetime :end
      t.integer :status, default: 0, null: false
      t.integer :attempt_number, default: 0, null: false

      t.timestamps
    end
  end
end

class CreateEmployeeAbsences < ActiveRecord::Migration[5.1]
  def change
    create_table :employee_absences do |t|
      t.references :employee, foreign_key: {to_table: :next_sgad_employees}
      t.references :absence_type, foreign_key: true
      t.date :returned_at, null: false
      t.date :left_at, null: false
      t.integer :absent_days_number, null: false, default: 1

      t.timestamps
    end
  end
end

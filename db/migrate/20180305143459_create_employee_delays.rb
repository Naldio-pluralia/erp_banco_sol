class CreateEmployeeDelays < ActiveRecord::Migration[5.1]
  def change
    create_table :employee_delays do |t|
      t.references :employee, foreign_key: {to_table: :next_sgad_employees}
      t.references :absence_type, foreign_key: true
      t.datetime :arrived_at, null: false
      t.integer :number_of_hours_late, null: false, default: 1

      t.timestamps
    end
  end
end

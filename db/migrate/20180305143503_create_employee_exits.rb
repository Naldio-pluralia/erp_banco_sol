class CreateEmployeeExits < ActiveRecord::Migration[5.1]
  def change
    create_table :employee_exits do |t|
      t.references :employee, foreign_key: {to_table: :next_sgad_employees}
      t.references :absence_type, foreign_key: true
      t.integer :kind, null: false, default: 0
      t.date :date, null: false
      t.time :left_at, null: false
      t.time :returned_at, null: false
      t.integer :number_of_hours_absent, null: false, default: 1

      t.timestamps
    end
  end
end

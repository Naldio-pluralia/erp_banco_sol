class CreateEmployeeVacations < ActiveRecord::Migration[5.1]
  def change
    create_table :employee_vacations do |t|
      t.references :employee, foreign_key: {to_table: :next_sgad_employees}
      t.date :left_at, null: false
      t.date :returned_at, null: false

      t.timestamps
    end
  end
end

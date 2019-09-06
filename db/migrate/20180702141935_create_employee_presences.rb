class CreateEmployeePresences < ActiveRecord::Migration[5.1]
  def change
    create_table :employee_presences do |t|
      t.references :employee, foreign_key: {to_table: :next_sgad_employees}
      t.date :date, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end

class CreateEmployeePaygrades < ActiveRecord::Migration[5.1]
  def change
    create_table :employee_paygrades do |t|
      t.integer :level, default: 0, null: false
      t.integer :paygrade, null: false
      t.date :since, null: false
      t.date :until
      t.references :employee, foreign_key: {to_table: :next_sgad_employees}
      t.references :paygrade_change_reason, foreign_key: true

      t.timestamps
    end
  end
end

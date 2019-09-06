class CreateEmployeeRegimes < ActiveRecord::Migration[5.1]
  def change
    create_table :employee_regimes do |t|
      t.integer :regime, default: 0, null: false
      t.time :enters_at, null: false
      t.time :leaves_at, null: false
      t.references :employee, foreign_key: {to_table: :next_sgad_employees}

      t.timestamps
    end
  end
end

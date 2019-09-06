class CreateSalaries < ActiveRecord::Migration[5.1]
  def change
    create_table :salaries do |t|
      t.decimal :base_value, null: false, default: 0
      t.decimal :value, null: false, default: 0
      t.decimal :status, null: false, default: 0
      t.date :period, null: false
      t.references :paygrade_board, foreign_key: true
      t.references :employee_paygrade, foreign_key: true

      t.timestamps
    end
  end
end

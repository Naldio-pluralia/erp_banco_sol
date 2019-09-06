class CreateWageIncomeTaxSalaries < ActiveRecord::Migration[5.1]
  def change
    create_table :wage_income_tax_salaries do |t|
      t.decimal :value, default: 0, null: false
      t.references :salary, foreign_key: true
      t.references :wage_income_tax, foreign_key: true

      t.timestamps
    end
  end
end

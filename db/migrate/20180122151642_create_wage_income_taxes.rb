class CreateWageIncomeTaxes < ActiveRecord::Migration[5.1]
  def change
    create_table :wage_income_taxes do |t|
      t.string :name, null: false
      t.string :abbr_name, null: false
      t.decimal :exempt_up_to, default: 0, null: false
      t.decimal :max_wage, default: 0, null: false
      t.decimal :max_wage_fixed_portion, default: 0, null: false
      t.decimal :percentage_over_max_wage_excess, default: 0, null: false
      t.decimal :max_wage_excess_of, default: 0, null: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end

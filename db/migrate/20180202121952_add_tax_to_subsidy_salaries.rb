class AddTaxToSubsidySalaries < ActiveRecord::Migration[5.1]
  def change
    add_column :subsidy_salaries, :base_value, :decimal, default: 0, null: false
    add_column :subsidy_salaries, :taxed_value, :decimal, default: 0, null: false
    remove_column :subsidy_salaries, :value, :decimal, default: 0, null: false
    add_reference :subsidy_salaries, :tax_type, foreign_key: true
  end
end

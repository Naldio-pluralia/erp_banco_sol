class AddColumnsToTaxTypes < ActiveRecord::Migration[5.1]
  def change
    add_column :tax_types, :kind, :integer, default: 0, null: false
    add_column :tax_types, :percentage_from_employee, :decimal, default: 0, null: false
    add_column :tax_types, :percentage_from_employer, :decimal, default: 0, null: false
    add_column :tax_types, :exempt_up_to, :decimal, default: 0, null: false
    add_column :tax_types, :max_wage, :decimal, default: 0, null: false
    add_column :tax_types, :max_wage_fixed_portion, :decimal, default: 0, null: false
    add_column :tax_types, :percentage_over_max_wage_excess, :decimal, default: 0, null: false
    add_column :tax_types, :max_wage_excess_of, :decimal, default: 0, null: false
  end
end

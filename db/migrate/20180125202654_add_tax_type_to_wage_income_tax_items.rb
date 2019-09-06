class AddTaxTypeToWageIncomeTaxItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :wage_income_tax_items, :tax_type, foreign_key: true
  end
end

class RemoveWageIncomeTaxToWageIncomeTaxItems < ActiveRecord::Migration[5.1]
  def change
    remove_reference :wage_income_tax_items, :wage_income_tax
  end
end

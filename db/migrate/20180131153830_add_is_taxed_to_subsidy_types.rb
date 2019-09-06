class AddIsTaxedToSubsidyTypes < ActiveRecord::Migration[5.1]
  def change
    add_column :subsidy_types, :is_taxed, :boolean, default: false, null: false
  end
end

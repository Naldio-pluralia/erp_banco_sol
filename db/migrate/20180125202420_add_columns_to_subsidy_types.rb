class AddColumnsToSubsidyTypes < ActiveRecord::Migration[5.1]
  def change
    add_column :subsidy_types, :kind, :integer, default: 0, null: false
  end
end

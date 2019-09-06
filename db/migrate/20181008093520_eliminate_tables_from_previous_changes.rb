class EliminateTablesFromPreviousChanges < ActiveRecord::Migration[5.1]
  def up
    Plugin.generate_side_menu true
    drop_table :geographic_locations if table_exists? :geographic_locations
    drop_table :counties if table_exists? :counties
    drop_table :provinces if table_exists? :provinces
  end
  def down
  end
end
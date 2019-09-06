class AddColumnAncestryToPlugins < ActiveRecord::Migration[5.1]
  def change
    add_column :plugins, :ancestry, :string if table_exists? :plugins
    add_index :plugins, :ancestry if table_exists? :plugins
  end
end

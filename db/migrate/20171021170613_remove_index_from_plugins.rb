class RemoveIndexFromPlugins < ActiveRecord::Migration[5.1]
  def change
    remove_index "plugins", name: "index_plugins_on_ancestry" if table_exists? :plugins
    add_column :plugins, :parent_id, :integer if table_exists? :plugins
  end
end

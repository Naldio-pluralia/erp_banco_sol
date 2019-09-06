class RemoveColumnsFromPlugins < ActiveRecord::Migration[5.1]
  def change
    remove_column :plugins, :table_name, :string if table_exists? :plugins
    remove_column :plugins, :plugin_id_number, :integer if table_exists? :plugins
    add_column    :plugins, :is_active, :boolean, :default => :false if table_exists? :plugins
  end
end

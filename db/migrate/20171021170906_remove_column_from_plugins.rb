class RemoveColumnFromPlugins < ActiveRecord::Migration[5.1]
  def change
    remove_column :plugins, :ancestry if table_exists?(:plugins) && column_exists?(:plugins, :ancestry)
  end
end

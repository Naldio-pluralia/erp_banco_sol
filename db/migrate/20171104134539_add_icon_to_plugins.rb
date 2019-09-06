class AddIconToPlugins < ActiveRecord::Migration[5.1]
  def change
    add_column :plugins, :icon, :string, default: :folder_at_mtl, null: false
  end
end

class ChangeIsActiveFromPlugins < ActiveRecord::Migration[5.1]
  def change
    change_column :plugins, :is_active, :boolean, default: true, null: false
  end
end

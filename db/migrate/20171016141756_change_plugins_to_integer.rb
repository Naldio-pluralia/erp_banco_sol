class ChangePluginsToInteger < ActiveRecord::Migration[5.1]
  def change
    change_column :settings, :plugins, 'text[] USING ARRAY[plugins]::INTEGER[]', array: true, default: []
  end
end

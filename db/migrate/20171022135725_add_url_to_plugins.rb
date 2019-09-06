class AddUrlToPlugins < ActiveRecord::Migration[5.1]
  def change
    add_column :plugins, :url, :string
  end
end

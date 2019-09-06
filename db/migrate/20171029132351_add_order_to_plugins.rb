class AddOrderToPlugins < ActiveRecord::Migration[5.1]
  def change
    add_column :plugins, :order, :integer, default: 100, null: false
    add_column :plugins, :if_can, :string
  end
end

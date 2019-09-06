class AddIsSideMenuMinimizedToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :is_menu_minimized, :boolean, default: false, null: false
  end
end

class ChangeColumnIsMenuMinimizedFromAdmins < ActiveRecord::Migration[5.1]
  def change
    change_column :admins, :is_menu_minimized, :boolean, default: false, null: false
  end
end

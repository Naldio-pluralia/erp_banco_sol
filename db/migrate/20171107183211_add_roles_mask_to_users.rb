class AddRolesMaskToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :roles_mask, :integer, default: -1, null: false
    add_column :admins, :roles_mask, :integer, default: -1, null: false
  end
end

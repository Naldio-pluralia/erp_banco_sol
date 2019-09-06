class AddPermissionToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :permissions, :string, array: true, default: []
    add_column :admins, :permissions, :string, array: true, default: []
    add_column :roles, :permissions, :string, array: true, default: []
  end
end

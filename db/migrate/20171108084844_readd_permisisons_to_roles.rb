class ReaddPermisisonsToRoles < ActiveRecord::Migration[5.1]
  def change
    remove_column :roles, :permissions, :string, array: true, default: [] if column_exists? :roles, :permissions
    add_column :roles, :permissions, :string, array: true, default: []
  end
end

class AddMiddleNameToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :middle_name, :string
    add_column :admins, :middle_name, :string
  end
end

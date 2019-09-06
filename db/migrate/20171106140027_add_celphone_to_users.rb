class AddCelphoneToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :cellphone, :string
    add_column :admins, :cellphone, :string
  end
end

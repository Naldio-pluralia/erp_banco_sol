class CreateAdmins < ActiveRecord::Migration[5.1]
  def change
    create_table :admins do |t|
      t.string :first_name
      t.string :last_name
      t.boolean :is_menu_minimized
      t.string :avatar

      t.timestamps
    end
  end
end

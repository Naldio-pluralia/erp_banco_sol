class CreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :roles do |t|
      t.references :account, polymorphic: true
      t.integer :roles_mask, default: -1, null: false

      t.timestamps
    end
  end
end

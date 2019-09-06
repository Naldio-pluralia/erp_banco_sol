class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.integer :status, null: false, default: 0
      t.integer :group_type, null: false, default: 0

      t.timestamps
    end
  end
end

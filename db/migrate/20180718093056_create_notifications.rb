class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.string :description
      t.string :url

      t.timestamps
    end
  end
end

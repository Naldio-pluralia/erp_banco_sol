class CreateDateTypes < ActiveRecord::Migration[5.1]
  def up
    drop_table :date_types if table_exists? :date_types
    create_table :date_types do |t|
      t.string :name, null: false
      t.text :description
      t.date :date, null: false
      t.integer :kind, null: false, default: 1
      t.boolean :recurrent, default: false, null: false

      t.timestamps
    end
  end

  def down
    drop_table :date_types if table_exists? :date_types
  end
end

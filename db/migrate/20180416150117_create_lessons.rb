class CreateLessons < ActiveRecord::Migration[5.1]
  def change
    create_table :lessons do |t|
      t.string :number, null: false, default: 1
      t.string :name, null: false
      t.string :video, null: false
      t.text :text, null: false
      t.references :chapter, foreign_key: {to_table: :chapters}

      t.timestamps
    end
  end
end

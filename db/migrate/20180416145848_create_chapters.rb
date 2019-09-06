class CreateChapters < ActiveRecord::Migration[5.1]
  def change
    create_table :chapters do |t|
      t.integer :number, null: false
      t.string :name, null: false
      t.references :course, foreign_key: {to_table: :courses}
      
      t.timestamps
    end
  end
end

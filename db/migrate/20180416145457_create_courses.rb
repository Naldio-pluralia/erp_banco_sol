class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :name, null: false
      t.integer :status, null: false, default: 0
      t.boolean :for_all, null: false, default: true

      t.timestamps
    end
  end
end

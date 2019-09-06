class CreateExams < ActiveRecord::Migration[5.1]
  def change
    create_table :exams do |t|

      t.references :chapter, foreign_key: {to_table: :chapters}
      t.decimal :expected_value, null: false

      t.timestamps
    end
  end
end

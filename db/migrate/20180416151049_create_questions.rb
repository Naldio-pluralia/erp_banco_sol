class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.integer :number, null: false
      t.text :description, null: false
      t.integer :type, null: false
      t.decimal :value, null: false
      t.boolean :boolean_option, null: false, default: true

      t.references :exam, foreign_key: {to_table: :exams}

      t.timestamps
    end
  end
end

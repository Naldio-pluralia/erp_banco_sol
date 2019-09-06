class CreateQuestionOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :question_options do |t|
      t.references :question, foreign_key: {to_table: :questions}
      t.integer :status, null: false

      t.timestamps
    end
  end
end

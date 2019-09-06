class CreateFunctionSkills < ActiveRecord::Migration[5.1]
  def change
    create_table :function_skills do |t|
      t.decimal :min, default: 0, null: false
      t.decimal :recomended, default: 5, null: false
      t.references :skill, foreign_key: true
      t.references :function, foreign_key: {to_table: :next_sgad_functions}

      t.timestamps
    end
  end
end

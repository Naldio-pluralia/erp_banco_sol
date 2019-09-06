class CreateGeneralGoals < ActiveRecord::Migration[5.1]
  def change
    create_table :general_goals do |t|
      t.integer :period, null: false, default: 0
      t.text :objectives, null: false, default: ''
      t.float :target, null: false, default: 0.0
      t.integer :mode, null: false, default: 0
      t.references :assessment, foreign_key: {to_table: :next_sgad_assessments}, index: true
      t.references :function, foreign_key: {to_table: :next_sgad_functions}, index: true
      t.references :position, foreign_key: {to_table: :next_sgad_positions}, index: true

      t.timestamps
    end
  end
end

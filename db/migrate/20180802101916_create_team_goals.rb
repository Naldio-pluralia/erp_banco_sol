class CreateTeamGoals < ActiveRecord::Migration[5.1]
  def change
    create_table :team_goals do |t|
      t.references :general_goal, foreign_key: true
      t.references :function, foreign_key: {to_table: :next_sgad_functions}, index: true
      t.references :position, foreign_key: {to_table: :next_sgad_positions}, index: true
      t.references :assessment, foreign_key: {to_table: :next_sgad_assessments}, index: true
      t.integer :period, null: false, default: 0
      t.text :objectives, null: false, default: ''
      t.float :target, null: false, default: 0
      t.integer :mode, null: false, default: 0

      t.timestamps
    end
  end
end

# This migration comes from next_sgad (originally 20171024172007)
class CreateNextSgadGoals < ActiveRecord::Migration[5.1]
  def change
    create_table :next_sgad_goals do |t|
      t.string :name
      t.integer :goal_type, default: 0, null: false
      t.integer :state, default: 0, null: false
      t.integer :nature, default: 0, null: false
      t.integer :unit, default: 0, null: false
      t.float :target, default: 0, null: false
      t.float :percentage_on_the_type, default: 0, null: false
      t.float :percentage, default: 0, null: false

      t.timestamps
    end

    add_reference :next_sgad_goals, :assessment, foreign_key: {to_table: :next_sgad_assessments}, index: true
  end
end

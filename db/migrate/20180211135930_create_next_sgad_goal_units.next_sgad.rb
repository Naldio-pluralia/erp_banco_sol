# This migration comes from next_sgad (originally 20180211132528)
class CreateNextSgadGoalUnits < ActiveRecord::Migration[5.1]
  def change
    create_table :next_sgad_goal_units do |t|
      t.string :singular_name, null: false
      t.string :plural_name, null: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end
    add_reference :next_sgad_goals, :goal_unit, foreign_key: {to_table: :next_sgad_goal_units}, index: true
  end
end

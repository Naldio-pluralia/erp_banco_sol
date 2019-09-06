# This migration comes from next_sgad (originally 20171027213833)
class CreateJoinTableGoalPosition < ActiveRecord::Migration[5.1]
  def change
    create_join_table :next_sgad_positions, :next_sgad_goals do |t|
      t.index [:next_sgad_position_id, :next_sgad_goal_id], name: 'index_next_sgad_goals_positions_on_position_id_and_goal_id'
      # t.index [:next_sgad_goal_id, :next_sgad_position_id]
    end
  end
end

# This migration comes from next_sgad (originally 20171119152032)
class CreateJoinTableGoalFunction < ActiveRecord::Migration[5.1]
  def change
    create_join_table :next_sgad_goals, :next_sgad_functions do |t|
      t.index [:next_sgad_goal_id, :next_sgad_function_id], name: 'idx_nxt_sgd_fctns_gls_n_nxt_sgd_goal_id_and_nt_sgd_function_id'
      # t.index [:next_sgad_function_id, :next_sgad_goal_id]
    end
  end
end

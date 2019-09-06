class CreateJoinTableForGolsResources < ActiveRecord::Migration[5.1]
  def change
    # general_goals join table
    create_join_table :general_goals, :next_sgad_functions do |t|
      t.index [:general_goal_id, :next_sgad_function_id], name: 'idx_general_goals_functions_db'
    end
    create_join_table :general_goals, :next_sgad_positions do |t|
      t.index [:general_goal_id, :next_sgad_position_id], name: 'idx_general_goals_positions_db'
    end
    create_join_table :general_goals, :next_sgad_employees do |t|
      t.index [:general_goal_id, :next_sgad_employee_id], name: 'idx_general_goals_employees_db'
    end
    p 'create general_goal join table'

    # team_goals join table
    create_join_table :team_goals, :next_sgad_functions do |t|
      t.index [:team_goal_id, :next_sgad_function_id], name: 'idx_teame_goals_functions_db'
    end
    create_join_table :team_goals, :next_sgad_positions do |t|
      t.index [:team_goal_id, :next_sgad_position_id], name: 'idx_team_goals_positions_db'
    end
    create_join_table :team_goals, :next_sgad_employees do |t|
      t.index [:team_goal_id, :next_sgad_employee_id], name: 'idx_team_goals_employees_db'
    end
    p 'create team_goals join table'

    # corporate_goals join table
    create_join_table :corporate_goals, :next_sgad_functions do |t|
      t.index [:corporate_goal_id, :next_sgad_function_id], name: 'idx_corporate_goals_functions_db'
    end
    create_join_table :corporate_goals, :next_sgad_positions do |t|
      t.index [:corporate_goal_id, :next_sgad_position_id], name: 'idx_corporate_goals_positions_db'
    end
    create_join_table :corporate_goals, :next_sgad_employees do |t|
      t.index [:corporate_goal_id, :next_sgad_employee_id], name: 'idx_corporate_goals_employees_db'
    end
    p 'create corporate_goals join table'
  end
end

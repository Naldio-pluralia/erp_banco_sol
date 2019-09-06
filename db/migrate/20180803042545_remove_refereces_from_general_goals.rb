class RemoveReferecesFromGeneralGoals < ActiveRecord::Migration[5.1]
  def change
    # remove references on general_goals next_sgad_function
    remove_reference :general_goals, :function, foreign_key: {to_table: :next_sgad_functions}, index: true
    remove_reference :general_goals, :position, foreign_key: {to_table: :next_sgad_positions}, index: true

    # remove references on corporate_goals
    remove_reference :corporate_goals, :function, foreign_key: {to_table: :next_sgad_functions}, index: true
    remove_reference :corporate_goals, :position, foreign_key: {to_table: :next_sgad_positions}, index: true
    # remove_reference :corporate_goals, :general_goal, foreign_key: true

    # remove references on team_goals
    remove_reference :team_goals, :function, foreign_key: {to_table: :next_sgad_functions}, index: true
    remove_reference :team_goals, :position, foreign_key: {to_table: :next_sgad_positions}, index: true
    # remove_reference :team_goals, :general_goal, foreign_key: true
  end
end

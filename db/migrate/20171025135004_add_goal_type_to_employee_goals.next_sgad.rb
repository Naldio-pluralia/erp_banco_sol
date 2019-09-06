# This migration comes from next_sgad (originally 20171025134655)
class AddGoalTypeToEmployeeGoals < ActiveRecord::Migration[5.1]
  def change
    add_column :next_sgad_employee_goals, :unit, :integer, default: 0, null: false
    add_column :next_sgad_employee_goals, :goal_type, :integer, default: 0, null: false
    add_column :next_sgad_employee_goals, :nature, :integer, default: 0, null: false
    add_column :next_sgad_employee_goals, :target, :float, default: 0, null: false
  end
end

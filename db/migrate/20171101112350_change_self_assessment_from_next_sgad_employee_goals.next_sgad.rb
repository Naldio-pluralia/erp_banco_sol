# This migration comes from next_sgad (originally 20171101112232)
class ChangeSelfAssessmentFromNextSgadEmployeeGoals < ActiveRecord::Migration[5.1]
  def up
    change_column :next_sgad_employee_goals, :self_assessment, :decimal, null: false, default: 0
    change_column :next_sgad_employee_goals, :supervisor_assessment, :decimal, null: false, default: 0
    change_column :next_sgad_employee_goals, :final_assessment, :decimal, null: false, default: 0
  end

  def down
    change_column :next_sgad_employee_goals, :self_assessment, :integer, null: false, default: 0
    change_column :next_sgad_employee_goals, :supervisor_assessment, :integer, null: false, default: 0
    change_column :next_sgad_employee_goals, :final_assessment, :integer, null: false, default: 0
  end
end

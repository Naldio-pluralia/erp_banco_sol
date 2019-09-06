class AddColumnReportToNextSgadEmployeeGoal < ActiveRecord::Migration[5.1]
  def change
    add_column :next_sgad_employee_goals, :report, :boolean, default: false, null: false
  end
end

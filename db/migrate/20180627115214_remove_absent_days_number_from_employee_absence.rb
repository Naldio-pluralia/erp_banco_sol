class RemoveAbsentDaysNumberFromEmployeeAbsence < ActiveRecord::Migration[5.1]
  def change
    remove_column :employee_absences, :absent_days_number, :integer, null: false, default: 0
  end
end

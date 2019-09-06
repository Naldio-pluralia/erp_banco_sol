class AddOtherResultsToNextSgadEmployeesAssessments < ActiveRecord::Migration[5.1]
  def up
    add_column :next_sgad_employees_assessments, :self_result, :decimal, default: 0, null: false
    add_column :next_sgad_employees_assessments, :supervisor_result, :decimal, default: 0, null: false

    employees = Employee.all.to_a
    Assessment.all.each do |assessment|
      employees.each do |employee|
        p assessment.employee_assessment(employee)
      end
    end
  end

  def down
    remove_column :next_sgad_employees_assessments, :self_result, :decimal, default: 0, null: false
    remove_column :next_sgad_employees_assessments, :supervisor_result, :decimal, default: 0, null: removese
  end
end

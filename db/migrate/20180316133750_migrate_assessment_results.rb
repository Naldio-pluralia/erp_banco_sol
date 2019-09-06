class MigrateAssessmentResults < ActiveRecord::Migration[5.1]
  def change
    employees = Employee.all.to_a
    Assessment.all.each do |assessment|
      employees.each do |employee|
        p assessment.employee_assessment(employee)
      end
    end
  end
end

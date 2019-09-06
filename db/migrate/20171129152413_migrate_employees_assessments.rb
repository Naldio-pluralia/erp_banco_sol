class MigrateEmployeesAssessments < ActiveRecord::Migration[5.1]
  def change
    assessments = Assessment.all.map{|a| {assessment_id: a.id}}
    employees = Employee.all
    employees.each do |e|
      EmployeeAssessment.create(assessments) do |eg|
        eg.employee_id = e.id
      end
    end
  end
end

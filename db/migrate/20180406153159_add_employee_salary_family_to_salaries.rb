class AddEmployeeSalaryFamilyToSalaries < ActiveRecord::Migration[5.1]
  def change
    add_reference :salaries, :employee_salary_family, foreign_key: true
  end
end

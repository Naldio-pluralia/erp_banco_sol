class AddColumnsEmployeeIdToDepartment < ActiveRecord::Migration[5.1]
  def change
    #add_reference :employee_justifications, :employee_absence, foreign_key: true, index: true
    add_reference :next_sgad_departments, :employee, foreign_key: {to_table: :next_sgad_employees}, index: true
  end
end

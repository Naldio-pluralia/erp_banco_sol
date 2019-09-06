class AddEmployeeAbsenceToJustification < ActiveRecord::Migration[5.1]
  def change
    p EmployeeJustification.all.each(&:destroy)
    p 'Apagados'
    add_reference :employee_justifications, :employee_absence, foreign_key: true, index: true
    add_reference :employee_justifications, :employee_delay, foreign_key: true, index: true
    add_reference :employee_justifications, :employee_exit, foreign_key: true, index: true
  end
end

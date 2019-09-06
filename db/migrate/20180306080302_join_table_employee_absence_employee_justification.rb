class JoinTableEmployeeAbsenceEmployeeJustification < ActiveRecord::Migration[5.1]
  def change
    create_join_table :employee_absences, :employee_justifications do |t|
      t.index [:employee_absence_id, :employee_justification_id], name: 'idx_absences_justifications_on_absence_id_and_justification_id'
      # t.index [:employee_justification_id, :employee_absence_id]
    end
  end
end

class JoinTableEmployeeExitEmployeeJustification < ActiveRecord::Migration[5.1]
  def change
    create_join_table :employee_exits, :employee_justifications do |t|
      t.index [:employee_exit_id, :employee_justification_id], name: 'idx_exits_justifications_on_exit_id_and_justification_id'
      # t.index [:employee_justification_id, :employee_exit_id]
    end
  end
end

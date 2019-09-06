class JoinTableEmployeeDelayEmployeeJustification < ActiveRecord::Migration[5.1]
  def change
    create_join_table :employee_delays, :employee_justifications do |t|
      t.index [:employee_delay_id, :employee_justification_id], name: 'idx_delays_justifications_on_delay_id_and_justification_id'
      # t.index [:employee_justification_id, :employee_delay_id]
    end
  end
end

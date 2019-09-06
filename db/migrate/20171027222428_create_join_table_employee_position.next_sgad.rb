# This migration comes from next_sgad (originally 20171027221550)
class CreateJoinTableEmployeePosition < ActiveRecord::Migration[5.1]
  def change
    create_join_table :next_sgad_employees, :next_sgad_positions do |t|
      t.index [:next_sgad_employee_id, :next_sgad_position_id], name: 'idx_nxt_sgad_employees_positions_on_employee_id_and_position_id'
      # t.index [:next_sgad_position_id, :next_sgad_employee_id]
    end
  end
end

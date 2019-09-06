# This migration comes from next_sgad (originally 20171026061315)
class RemoveOldReferenceColumns < ActiveRecord::Migration[5.1]
  def change
    remove_column :next_sgad_positions, :next_sgad_department_id
    remove_column :next_sgad_positions, :next_sgad_employee_id
    remove_column :next_sgad_positions, :next_sgad_position_id
    remove_column :next_sgad_positions, :employee_id
  end
end

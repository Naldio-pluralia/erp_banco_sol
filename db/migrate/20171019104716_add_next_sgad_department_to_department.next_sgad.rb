# This migration comes from next_sgad (originally 20171015073528)
class AddNextSgadDepartmentToDepartment < ActiveRecord::Migration[5.1]
  def change
    add_reference :next_sgad_departments, :next_sgad_department, foreign_key: true, index: true
    add_reference :next_sgad_positions,   :next_sgad_position, foreign_key: true, index: true
  end
end

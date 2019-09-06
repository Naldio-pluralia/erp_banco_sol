# This migration comes from next_sgad (originally 20171024193750)
class CopiesInfoFromOldReferences < ActiveRecord::Migration[5.1]
  def change
    Department.all.each{|d| d.update_columns(department_id: d.next_sgad_department_id)}
    Position.all.each{|d| d.update_columns(position_id: d.next_sgad_position_id)}
    Position.all.each{|d| d.update_columns(department_id: d.next_sgad_department_id)}
    Position.all.each{|d| d.update_columns(employee_id: d.next_sgad_employee_id)}
  end
end

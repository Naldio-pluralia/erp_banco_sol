# This migration comes from next_sgad (originally 20171112172436)
class AddDepartmentToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_reference :next_sgad_attendances,    :department, foreign_key: {to_table: :next_sgad_departments}, index: true
    add_reference :next_sgad_justifications, :department, foreign_key: {to_table: :next_sgad_departments}, index: true
  end
end

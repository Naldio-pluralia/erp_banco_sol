# This migration comes from next_sgad (originally 20171111093524)
class AddReferencesToJustificationsAndAttendences < ActiveRecord::Migration[5.1]
  def change
    add_reference :next_sgad_attendances, :assessment, foreign_key: {to_table: :next_sgad_assessments}, index: true
    add_reference :next_sgad_attendances, :position, foreign_key: {to_table: :next_sgad_positions}, index: true
    add_reference :next_sgad_attendances, :employee, foreign_key: {to_table: :next_sgad_employees}, index: true
    add_reference :next_sgad_justifications, :assessment, foreign_key: {to_table: :next_sgad_assessments}, index: true
    add_reference :next_sgad_justifications, :position, foreign_key: {to_table: :next_sgad_positions}, index: true
    add_reference :next_sgad_justifications, :employee, foreign_key: {to_table: :next_sgad_employees}, index: true
  end
end

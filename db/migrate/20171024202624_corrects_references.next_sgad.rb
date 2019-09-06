# This migration comes from next_sgad (originally 20171024192907)
class CorrectsReferences < ActiveRecord::Migration[5.1]
  def change
    add_reference :next_sgad_departments, :department, foreign_key: {to_table: :next_sgad_departments}, index: true
    add_reference :next_sgad_positions, :position, foreign_key: {to_table: :next_sgad_positions}, index: true
    add_reference :next_sgad_positions, :department, foreign_key: {to_table: :next_sgad_departments}, index: true
    add_reference :next_sgad_positions, :employee, foreign_key: {to_table: :next_sgad_employees}, index: true
  end
end

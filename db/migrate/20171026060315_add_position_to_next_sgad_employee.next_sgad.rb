# This migration comes from next_sgad (originally 20171026060110)
class AddPositionToNextSgadEmployee < ActiveRecord::Migration[5.1]
  def change
    add_reference :next_sgad_employees, :position, foreign_key: {to_table: :next_sgad_positions}, index: true
  end
end

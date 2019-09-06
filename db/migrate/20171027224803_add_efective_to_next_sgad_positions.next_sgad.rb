# This migration comes from next_sgad (originally 20171027223737)
class AddEfectiveToNextSgadPositions < ActiveRecord::Migration[5.1]
  def change
    add_reference :next_sgad_positions, :efective, foreign_key: {to_table: :next_sgad_employees}, index: true
  end
end

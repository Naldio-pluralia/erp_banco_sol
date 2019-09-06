# This migration comes from next_sgad (originally 20171027210912)
class AddFunctionToNextSgadPositions < ActiveRecord::Migration[5.1]
  def change
    add_reference :next_sgad_positions, :function, foreign_key: {to_table: :next_sgad_functions}, index: true
  end
end

# This migration comes from next_sgad (originally 20171026055530)
class AddPositionToNextSgadGoals < ActiveRecord::Migration[5.1]
  def change
    add_reference :next_sgad_goals, :position, foreign_key: {to_table: :next_sgad_positions}, index: true
  end
end

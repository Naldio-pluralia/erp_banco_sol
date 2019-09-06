# This migration comes from next_sgad (originally 20171026142240)
class AddPositionToNextSgadEmployeeGoals < ActiveRecord::Migration[5.1]
  def change
    add_reference :next_sgad_employee_goals, :position, foreign_key: {to_table: :next_sgad_positions}
  end
end

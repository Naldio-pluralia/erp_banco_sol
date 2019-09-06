# This migration comes from next_sgad (originally 20171029160044)
class AddAmountToNextSgadEmployeeGoals < ActiveRecord::Migration[5.1]
  def change
    add_column :next_sgad_employee_goals, :amount, :decimal, default: 0, null: false
  end
end

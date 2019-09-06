# This migration comes from next_sgad (originally 20171025135319)
class AddnameToNextSgadEmployeeGoals < ActiveRecord::Migration[5.1]
  def change
    add_column :next_sgad_employee_goals, :name, :string
  end
end

# This migration comes from next_sgad (originally 20171027230033)
class ClearData < ActiveRecord::Migration[5.1]
  def change
    EmployeeGoal.all.delete_all
    Goal.all.delete_all
    Position.all.delete_all
  end
end

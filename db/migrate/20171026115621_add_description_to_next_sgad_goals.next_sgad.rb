# This migration comes from next_sgad (originally 20171026115447)
class AddDescriptionToNextSgadGoals < ActiveRecord::Migration[5.1]
  def change
    add_column :next_sgad_goals, :description, :text
    add_column :next_sgad_employee_goals, :description, :text
  end
end

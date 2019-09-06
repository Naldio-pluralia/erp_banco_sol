# This migration comes from next_sgad (originally 20171119122339)
class AddForEveryoneToNextSgadGoals < ActiveRecord::Migration[5.1]
  def change
    add_column :next_sgad_goals, :for_everyone, :boolean, default: false, null: false
  end
end

# This migration comes from next_sgad (originally 20180208110338)
class AddPeriodToGoals < ActiveRecord::Migration[5.1]
  def change
    add_column :next_sgad_goals, :period, :integer, default: 0, null: false
  end
end

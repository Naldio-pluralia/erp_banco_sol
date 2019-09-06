# This migration comes from next_sgad (originally 20171027230032)
class RemovePositionFromNextSgadEmployee < ActiveRecord::Migration[5.1]
  def change
    remove_column :next_sgad_employees, :position_id, :bigint
    remove_column :next_sgad_goals, :position_id, :bigint
  end
end

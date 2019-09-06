# This migration comes from next_sgad (originally 20171019142918)
class RemoveTableConfigurations < ActiveRecord::Migration[5.1]
  def change
    drop_table :next_sgad_configurations
  end
end

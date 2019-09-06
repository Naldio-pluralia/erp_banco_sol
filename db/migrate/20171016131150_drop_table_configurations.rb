class DropTableConfigurations < ActiveRecord::Migration[5.1]
  def change
    drop_table :configurations if table_exists? :configurations
  end
end

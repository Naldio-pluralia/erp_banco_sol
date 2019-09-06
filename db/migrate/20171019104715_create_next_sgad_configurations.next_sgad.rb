# This migration comes from next_sgad (originally 20171014183337)
class CreateNextSgadConfigurations < ActiveRecord::Migration[5.1]
  def change
    create_table :next_sgad_configurations do |t|
      t.string :name
      t.text :description
      t.string :version

      t.timestamps
    end
  end
end

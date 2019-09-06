# This migration comes from next_sgad (originally 20171014175212)
class CreateNextSgadEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :next_sgad_employees do |t|
      t.string :name
      t.string :number
      t.integer :level

      t.timestamps
    end
  end
end

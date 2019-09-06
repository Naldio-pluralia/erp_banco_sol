# This migration comes from next_sgad (originally 20171014175507)
class CreateNextSgadPositions < ActiveRecord::Migration[5.1]
  def change
    create_table :next_sgad_positions do |t|
      t.string :name
      t.text :description
      t.string :number
      t.references :next_sgad_department, foreign_key: true, index: true
      t.references :next_sgad_employee, foreign_key: true, index: true

      t.timestamps
    end
  end
end

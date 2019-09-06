# This migration comes from next_sgad (originally 20171014174705)
class CreateNextSgadDepartments < ActiveRecord::Migration[5.1]
  def change
    create_table :next_sgad_departments do |t|
      t.string :name
      t.text :description
      t.string :number

      t.timestamps
    end
  end
end

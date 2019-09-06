# This migration comes from next_sgad (originally 20171027210543)
class CreateNextSgadFunctions < ActiveRecord::Migration[5.1]
  def change
    create_table :next_sgad_functions do |t|
      t.string :name

      t.timestamps
    end
  end
end

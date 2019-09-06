# This migration comes from next_sgad (originally 20171111081148)
class CreateNextSgadJustifications < ActiveRecord::Migration[5.1]
  def change
    create_table :next_sgad_justifications do |t|
      t.json :documents

      t.timestamps
    end
  end
end

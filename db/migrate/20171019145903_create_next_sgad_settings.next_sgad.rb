# This migration comes from next_sgad (originally 20171019143336)
class CreateNextSgadSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :next_sgad_settings do |t|
      t.string :name
      t.string :description
      t.string :version

      t.timestamps
    end
  end
end

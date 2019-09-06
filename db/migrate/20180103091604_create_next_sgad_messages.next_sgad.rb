# This migration comes from next_sgad (originally 20180103084157)
class CreateNextSgadMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :next_sgad_messages do |t|
      t.string :title
      t.text :body
      t.string :signature
      t.boolean :send_to_all, default: false, null: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end

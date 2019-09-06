class CreateNextSgadResults < ActiveRecord::Migration[5.1]
  def change
    create_table :next_sgad_results do |t|
      t.string :note
      t.string :attachment
      t.integer :state, default: 1, null: false
      t.integer :result_type
      t.integer :created_by

      t.timestamps
    end
  end
end

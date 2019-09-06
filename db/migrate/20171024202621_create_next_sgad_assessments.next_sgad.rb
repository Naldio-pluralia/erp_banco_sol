# This migration comes from next_sgad (originally 20171024154422)
class CreateNextSgadAssessments < ActiveRecord::Migration[5.1]
  def change
    create_table :next_sgad_assessments do |t|
      t.string :year
      t.integer :state, default: 0, null: false

      t.timestamps
    end
  end
end

# This migration comes from next_sgad (originally 20171115085324)
class CreateNextSgadActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :next_sgad_activities do |t|
      t.string :created_by, null: false, default: ""
      t.string :description, null: false, default: ""

      t.timestamps
    end
  end
end

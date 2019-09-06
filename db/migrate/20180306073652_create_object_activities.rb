class CreateObjectActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :object_activities do |t|
      t.text :description
      t.references :object, polymorphic: true
      t.references :creator, polymorphic: true

      t.timestamps
    end
  end
end

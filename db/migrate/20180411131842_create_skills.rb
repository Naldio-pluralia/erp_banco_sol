class CreateSkills < ActiveRecord::Migration[5.1]
  def change
    create_table :skills do |t|
      t.string :name

      t.timestamps
    end
  end

  def down
    drop_table :skills
  end
end

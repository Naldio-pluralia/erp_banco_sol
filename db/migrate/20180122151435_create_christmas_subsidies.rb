class CreateChristmasSubsidies < ActiveRecord::Migration[5.1]
  def change
    create_table :christmas_subsidies do |t|
      t.string :name, null: false
      t.string :abbr_name, null: false
      t.decimal :percentage, default: 0, null: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end

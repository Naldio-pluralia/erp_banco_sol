class CreateTimeSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :time_settings do |t|
      t.integer :number_of_months_to_enjoy_vacation, default: 14, null: false

      t.timestamps
    end
  end
end

class CreatePaygradeChangeReasons < ActiveRecord::Migration[5.1]
  def change
    create_table :paygrade_change_reasons do |t|
      t.string :reason

      t.timestamps
    end
  end
end

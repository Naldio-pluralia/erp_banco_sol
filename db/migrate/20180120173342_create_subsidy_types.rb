class CreateSubsidyTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :subsidy_types do |t|
      t.string :name, null: false
      t.string :abbr_name, null: false
      t.string :code
      t.integer :value_mode, default: 0, null: false
      t.decimal :value, default: 0, null: false
      t.boolean :for_all, default: true, null: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end

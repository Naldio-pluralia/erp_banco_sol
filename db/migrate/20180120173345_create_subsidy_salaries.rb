class CreateSubsidySalaries < ActiveRecord::Migration[5.1]
  def change
    create_table :subsidy_salaries do |t|
      t.decimal :value, null: false, default: 0
      t.references :salary, foreign_key: true
      t.references :subsidy_type, foreign_key: true

      t.timestamps
    end
  end
end

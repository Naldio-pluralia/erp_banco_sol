class CreateVacationSubsidySalaries < ActiveRecord::Migration[5.1]
  def change
    create_table :vacation_subsidy_salaries do |t|
      t.decimal :value, default: 0, null: false
      t.decimal :percentage, default: 100, null: false
      t.integer :year, null: false
      t.references :salary, foreign_key: true
      t.references :vacation_subsidy, foreign_key: true

      t.timestamps
    end
  end
end

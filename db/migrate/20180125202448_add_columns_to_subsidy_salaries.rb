class AddColumnsToSubsidySalaries < ActiveRecord::Migration[5.1]
  def change
    add_column :subsidy_salaries, :year, :integer
    add_column :subsidy_salaries, :percentage, :decimal, default: 0, null: false
  end
end

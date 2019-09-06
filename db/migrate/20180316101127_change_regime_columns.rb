class ChangeRegimeColumns < ActiveRecord::Migration[5.1]
  def up
    change_column :employee_regimes, :enters_at, :time, null: true
    change_column :employee_regimes, :leaves_at, :time, null: true
  end
  def down
    change_column :employee_regimes, :enters_at, :time, null: false
    change_column :employee_regimes, :leaves_at, :time, null: false
  end
end

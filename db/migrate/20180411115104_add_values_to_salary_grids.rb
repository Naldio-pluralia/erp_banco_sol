class AddValuesToSalaryGrids < ActiveRecord::Migration[5.1]
  def up
    add_column :salary_grids, :value_105, :decimal, default: 0, null: false
    add_column :salary_grids, :value_115, :decimal, default: 0, null: false
    add_column :salary_grids, :value_120, :decimal, default: 0, null: false
  end

  def down
    remove_column :salary_grids, :value_105, :decimal, default: 0, null: false
    remove_column :salary_grids, :value_115, :decimal, default: 0, null: false
    remove_column :salary_grids, :value_120, :decimal, default: 0, null: false
  end
end

# This migration comes from next_sgad (originally 20171029074321)
class RenamePaygradeAndLevelFromEmployee < ActiveRecord::Migration[5.1]
  def change
    rename_column :next_sgad_employees, :paygrade, :paygrades
    rename_column :next_sgad_employees, :level, :paygrade
    rename_column :next_sgad_employees, :paygrades, :level
  end
end

class RemovePaygradeBoardFromSalary < ActiveRecord::Migration[5.1]
  def change
    remove_reference :salaries, :paygrade_board
  end
end

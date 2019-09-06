# This migration comes from next_sgad (originally 20171022113005)
class AddPaygradeToNextSgadEmployee < ActiveRecord::Migration[5.1]
  def change
    add_column :next_sgad_employees, :paygrade, :string
    add_column :next_sgad_employees, :avatar, :string
  end
end

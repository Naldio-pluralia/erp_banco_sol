class AddBaseSalaryToEmployeePaygrades < ActiveRecord::Migration[5.1]
  def change
    add_column :employee_paygrades, :base_salary, :decimal, default: 0, null: false
  end
end

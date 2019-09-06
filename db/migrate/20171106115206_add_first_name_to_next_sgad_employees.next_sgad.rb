# This migration comes from next_sgad (originally 20171106113735)
class AddFirstNameToNextSgadEmployees < ActiveRecord::Migration[5.1]
  def change
    add_column :next_sgad_employees, :first_name, :string
    add_column :next_sgad_employees, :last_name, :string
    add_column :next_sgad_employees, :middle_name, :string

    Employee.all.each do |employee|
      names = employee.name.split(' ')
      next if names.size <= 0
      if names.size == 1
        employee.first_name = names.first
      elsif names.size == 2
        employee.first_name = names.first
        employee.last_name = names.last

      elsif names.size > 2
        employee.first_name = names.shift
        employee.last_name = names.pop
        employee.middle_name = names.join(' ')
      end
      employee.save(validate: false)
    end
  end
end

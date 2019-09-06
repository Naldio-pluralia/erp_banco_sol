class AddValueToEmployeeCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :employee_courses, :value, :decimal, default: 0, null: false
  end
end

class AddIsApprovedToEmployeeCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :employee_courses, :is_approved, :boolean, default: false, null: false
  end
end

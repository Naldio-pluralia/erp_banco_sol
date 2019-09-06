class AddConclusionPercentageToEmployeeCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :employee_courses, :conclusion_percentage, :decimal, default: 0, null: false
  end
end

class RemoveColumnsFinalAssessmentFromEmployeeSkill < ActiveRecord::Migration[5.1]
  def change
    remove_column :employee_skills, :final_assessment, :decimal
  end
end

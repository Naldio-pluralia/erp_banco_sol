class AddColumnsSelfAssessmentSupervisorAssessmentFinalAssessmentToEmployeeSkill < ActiveRecord::Migration[5.1]
  def change
    add_column :employee_skills, :self_assessment, :decimal, default: 0, null: false
    add_column :employee_skills, :supervisor_assessment, :decimal, default: 0, null: false
    add_column :employee_skills, :final_assessment, :decimal, default: 0, null: false
  end
end

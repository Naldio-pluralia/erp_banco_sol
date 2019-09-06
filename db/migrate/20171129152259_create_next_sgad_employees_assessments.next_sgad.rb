# This migration comes from next_sgad (originally 20171129131333)
class CreateNextSgadEmployeesAssessments < ActiveRecord::Migration[5.1]
  def change
    create_table :next_sgad_employees_assessments do |t|
      t.integer :self_assessment_status
      t.integer :supervisor_assessment_status
      t.integer :final_assessment_status

      t.timestamps
    end
    add_reference :next_sgad_employees_assessments, :employee, foreign_key: {to_table: :next_sgad_employees}, index: true
    add_reference :next_sgad_employees_assessments, :assessment, foreign_key: {to_table: :next_sgad_assessments}, index: true
  end
end

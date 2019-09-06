# This migration comes from next_sgad (originally 20180316104924)
class AddAssessmentResultToNextSgadEmployeeAssessments < ActiveRecord::Migration[5.1]
  def change
    add_column :next_sgad_employees_assessments, :result, :decimal, default: 0, null: false
    add_column :next_sgad_employees_assessments, :manual, :boolean, default: false, null: false
  end
end

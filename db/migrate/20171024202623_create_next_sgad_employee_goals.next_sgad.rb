# This migration comes from next_sgad (originally 20171024181227)
class CreateNextSgadEmployeeGoals < ActiveRecord::Migration[5.1]
  def change
    create_table :next_sgad_employee_goals do |t|
      t.integer :self_assessment, default: 0, null: false
      t.integer :supervisor_assessment, default: 0, null: false
      t.integer :final_assessment, default: 0, null: false
      t.integer :state, default: 0, null: false
      t.float :percentage, default: 0, null: false

      t.timestamps
    end
    add_reference :next_sgad_employee_goals, :assessment, foreign_key: {to_table: :next_sgad_assessments}, index: true
    add_reference :next_sgad_employee_goals, :goal, foreign_key: {to_table: :next_sgad_goals}, index: true
    add_reference :next_sgad_employee_goals, :employee, foreign_key: {to_table: :next_sgad_employees}, index: true
  end
end

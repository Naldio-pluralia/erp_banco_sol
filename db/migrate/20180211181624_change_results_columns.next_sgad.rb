# This migration comes from next_sgad (originally 20180211181108)
class ChangeResultsColumns < ActiveRecord::Migration[5.1]
  def change
    remove_column :next_sgad_results, :result_type
    remove_column :next_sgad_results, :created_by
    remove_column :next_sgad_results, :employee_id
    remove_column :next_sgad_results, :assessment_id
    remove_column :next_sgad_results, :goal_id
    remove_column :next_sgad_results, :state
    remove_column :next_sgad_results, :result_nature
    add_column :next_sgad_results, :status, :integer, default: 0, null: false
  end
end

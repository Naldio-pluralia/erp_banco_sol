# This migration comes from next_sgad (originally 20171025093224)
class ChangeColumnYearFromAssessments < ActiveRecord::Migration[5.1]
  def change
    remove_column :next_sgad_assessments, :year
    add_column :next_sgad_assessments, :year, :integer, null: false
  end
end

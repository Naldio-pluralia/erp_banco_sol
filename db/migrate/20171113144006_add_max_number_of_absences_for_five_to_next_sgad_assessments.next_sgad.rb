# This migration comes from next_sgad (originally 20171113143825)
class AddMaxNumberOfAbsencesForFiveToNextSgadAssessments < ActiveRecord::Migration[5.1]
  def change
    add_column :next_sgad_assessments, :max_absences_for_five,  :integer, default: 0, null: false
    add_column :next_sgad_assessments, :max_absences_for_four,  :integer, default: 0, null: false
    add_column :next_sgad_assessments, :max_absences_for_three, :integer, default: 0, null: false
    add_column :next_sgad_assessments, :max_absences_for_two,   :integer, default: 0, null: false
    add_column :next_sgad_assessments, :max_absences_for_one,   :integer, default: 0, null: false
  end
end

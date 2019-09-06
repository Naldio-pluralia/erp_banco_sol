# This migration comes from next_sgad (originally 20171028140106)
class AddPercentagesToNextSagadAssessments < ActiveRecord::Migration[5.1]
  def change
    add_column :next_sgad_assessments, :skills_percentage, :decimal, default: 0, null: false
    add_column :next_sgad_assessments, :objectives_percentage, :decimal, default: 0, null: false
  end
end

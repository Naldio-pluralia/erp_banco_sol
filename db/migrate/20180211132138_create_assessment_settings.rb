class CreateAssessmentSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :assessment_settings do |t|

      t.timestamps
    end
  end
end

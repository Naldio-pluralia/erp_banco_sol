class CreateReportReviewers < ActiveRecord::Migration[5.1]
  def change
    create_table :report_reviewers do |t|
      t.references :employee, foreign_key: {to_table: :next_sgad_employees}

      t.timestamps
    end
  end
end

class CreateAbsenceDays < ActiveRecord::Migration[5.1]
  def change
    create_table :absence_days do |t|
      t.references :employee_absence, foreign_key: true
      t.date :date, null: false

      t.timestamps
    end
  end
end

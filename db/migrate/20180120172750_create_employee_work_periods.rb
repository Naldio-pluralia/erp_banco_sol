class CreateEmployeeWorkPeriods < ActiveRecord::Migration[5.1]
  def change
    create_table :employee_work_periods do |t|
      t.date :since, null: false
      t.date :until
      t.references :employee, foreign_key: {to_table: :next_sgad_employees}, index: true

      t.timestamps
    end
  end
end

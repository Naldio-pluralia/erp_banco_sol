class CreateVacationDays < ActiveRecord::Migration[5.1]
  def change
    create_table :vacation_days do |t|
      t.references :employee_vacation, foreign_key: true
      t.references :employee_avaliable_vacation, foreign_key: true
      t.date :date, null: false

      t.timestamps
    end
  end
end

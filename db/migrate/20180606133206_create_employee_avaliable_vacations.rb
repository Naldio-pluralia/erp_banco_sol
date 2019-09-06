class CreateEmployeeAvaliableVacations < ActiveRecord::Migration[5.1]
  def up
    create_table :employee_avaliable_vacations do |t|
      t.references :employee, foreign_key: {to_table: :next_sgad_employees}
      t.integer :year, null: false
      t.integer :number_of_days, null: false, default: 0
      t.date :valid_from, null: false
      t.date :valid_until, null: false

      t.timestamps
    end
    year = Date.current.year - 1
    valid_from = (Date.current - 1.year).beginning_of_year
    valid_until = ((Date.current - 1.year).end_of_year + TimeSetting.latest.number_of_months_to_enjoy_vacation.months).end_of_month
    data = Employee.all.ids.map{|f| {employee_id: f, number_of_days: 22, year: year, valid_from: valid_from, valid_until: valid_until}}.flatten
    p EmployeeAvaliableVacation.create(data)
  end

  def down
    drop_table :employee_avaliable_vacations
  end
end

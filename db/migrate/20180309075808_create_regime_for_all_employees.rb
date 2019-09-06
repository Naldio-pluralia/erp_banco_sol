class CreateRegimeForAllEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :regime_for_all_employees do |t|
      EmployeeRegime.create(Employee.all.map{|e| {employee_id: e.id, enters_at: Time.now.change(day:1, month: 1, year: 2000, hour: 8, minute: 0), leaves_at: Time.now.change(day:1, month: 1, year: 2000, hour: 16, minute: 0)}})
    end
  end
end

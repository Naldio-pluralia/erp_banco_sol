class CreateEmployeeVacationResponses < ActiveRecord::Migration[5.1]
  def change
    create_table :employee_vacation_responses do |t|
      t.references :employee_vacation, foreign_key: true
      t.references :employee, foreign_key: {to_table: :next_sgad_employees}
      t.integer :status, default: 0, null: false
      t.integer :kind, default: 0, null: false

      t.timestamps
    end
  end
end

class CreateEmployeeSalaryFamilies < ActiveRecord::Migration[5.1]
  def change
    create_table :employee_salary_families do |t|
      t.references :employee, foreign_key: {to_table: :next_sgad_employees}
      t.references :salary_family, foreign_key: true
      t.references :paygrade_change_reason, foreign_key: true
      t.string :level, null: false
      t.integer :paygrade, null: false
      t.date :since, null: false
      t.decimal :base_salary, null: false, default: 0

      t.timestamps
    end
  end
end

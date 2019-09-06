class CreateEmployeeRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :employee_requests do |t|
      t.references :employee, foreign_key: {to_table: :next_sgad_employees}
      t.string :name, null: false
      t.text :note
      t.references :request_type, foreign_key: true
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end

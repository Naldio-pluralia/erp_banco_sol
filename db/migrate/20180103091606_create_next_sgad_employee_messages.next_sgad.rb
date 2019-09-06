# This migration comes from next_sgad (originally 20180103085525)
class CreateNextSgadEmployeeMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :next_sgad_employee_messages do |t|
      t.references :message, foreign_key: {to_table: :next_sgad_messages}, index: true
      t.references :employee, foreign_key: {to_table: :next_sgad_employees}, index: true
      t.integer :status, default: 0, null: false
      t.string :title
      t.text :body
      t.string :signature

      t.timestamps
    end
  end
end

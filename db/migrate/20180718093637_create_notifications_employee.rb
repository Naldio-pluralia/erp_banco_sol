class CreateNotificationsEmployee < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications_employee do |t|
      t.integer :status, null: false, default: 0
      t.string :url
      # t.references :notification, foreign_key: true
      # t.references :employee, foreign_key: true
      t.references :notification, foreign_key: {to_table: :next_sgad_employees}, index: true
      t.references :employee, foreign_key: {to_table: :next_sgad_employees}, index: true

      t.timestamps
    end
  end
end

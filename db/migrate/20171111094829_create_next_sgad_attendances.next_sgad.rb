# This migration comes from next_sgad (originally 20171111093506)
class CreateNextSgadAttendances < ActiveRecord::Migration[5.1]
  def change
    drop_table :next_sgad_attendances if table_exists? :next_sgad_attendances
    create_table :next_sgad_attendances do |t|
      t.datetime :date
      t.integer :status, defautl: 0, null: false
      t.text :employee_note
      t.text :supervisor_note

      t.timestamps
    end
  end
end

class CreateApplications < ActiveRecord::Migration[5.1]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :email
      t.string :cellphone
      t.date :birthdate
      t.integer :civil_status, null: false, default: 0
      t.integer :dependents_number, null: false, default: 0
      t.string :note
      t.integer :status, null: false, default: 0
      t.integer :relevance, null: false, default: 0
      t.references :application, foreign_key: true
      t.references :employee, foreign_key: {to_table: :next_sgad_employees}

      t.timestamps
    end
  end
end

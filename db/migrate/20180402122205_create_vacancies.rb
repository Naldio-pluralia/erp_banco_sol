class CreateVacancies < ActiveRecord::Migration[5.1]
  def change
    create_table :vacancies do |t|
      t.string :position, null: false
      t.text :requirements, null: false
      t.string :number
      t.integer :status, null: false, default: 0
      t.integer :target, null: false, default: 0

      t.timestamps
    end
  end
end

class CreateEstablishments < ActiveRecord::Migration[5.1]
  def change
    create_table :establishments do |t|
      t.references :establishment_type, foreign_key: true
      t.references :municipality, foreign_key: true
      t.string :name
      t.string :code
      t.string :abbreviation
      t.date :inaugurated_at
      t.integer :atm_count
      t.integer :tpa_count
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
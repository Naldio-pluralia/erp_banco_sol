class CreateOrganicUnits < ActiveRecord::Migration[5.1]
  def change
    create_table :organic_units do |t|
      t.references :organic_unit_type, foreign_key: true
      t.string :name
      t.string :abbreviation

      t.timestamps
    end
  end
end
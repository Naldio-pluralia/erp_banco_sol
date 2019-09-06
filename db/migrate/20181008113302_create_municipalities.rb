class CreateMunicipalities < ActiveRecord::Migration[5.1]
  def change
    create_table :municipalities do |t|
      t.string :name
      t.references :province, foreign_key: true

      t.timestamps
    end
  end
end

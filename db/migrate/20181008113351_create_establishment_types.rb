class CreateEstablishmentTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :establishment_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
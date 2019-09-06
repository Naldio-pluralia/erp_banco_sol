class CreateAppliances < ActiveRecord::Migration[5.1]
  def change
    create_table :appliances do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :cellphone, null: false
      t.string :resume, null: false
      t.json :attachments
      t.text :note, null: false
      t.integer :relevance, null: false, default: 0

      t.timestamps
    end
  end
end

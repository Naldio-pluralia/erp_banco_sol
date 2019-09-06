class CreateSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :settings do |t|
      t.string :entity_name
      t.string :entity_address
      t.string :entity_logo
      t.string :framework_version
      t.string :rails_version
      t.string :ruby_version
      t.integer :plugins

      t.timestamps
    end
  end
end

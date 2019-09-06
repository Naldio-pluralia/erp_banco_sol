class CreateObjectAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :object_attachments do |t|
      t.string :file, null: false
      t.string :description, null: false
      t.string :extension_whitelist, array: true, default: [], null: false
      t.references :object, polymorphic: true

      t.timestamps
    end
  end
end

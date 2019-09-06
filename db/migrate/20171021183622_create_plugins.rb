class CreatePlugins < ActiveRecord::Migration[5.1]
  def change
    drop_table :plugins if table_exists? :plugins
    create_table :plugins do |t|
      t.string :name
      t.string :description
      t.boolean :is_active
      t.string :version
      t.integer :parent_id

      t.timestamps
    end
  end
end

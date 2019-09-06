class CreateRequestTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :request_types do |t|
      t.string :name, null: false
      t.text :note, null: false
      t.integer :code, default: 0, null: false
      t.integer :status, default: 0, null: false
      t.boolean :requires_supervisor_approval, default: true, null: false
      t.boolean :requires_supervisor_supervisor_approval, default: false, null: false
      t.boolean :requires_dpe_approval, default: false, null: false
      t.boolean :requires_dpe_supervisor_approval, default: false, null: false

      t.timestamps
    end
  end
end

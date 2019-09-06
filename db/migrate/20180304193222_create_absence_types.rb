class CreateAbsenceTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :absence_types do |t|
      t.string :name, null: false
      t.text :description
      t.integer :kind, default: 0, null: false
      t.integer :code, default: 0, null: false
      t.boolean :requires_document, default: false, null: false
      t.boolean :requires_justification, default: false, null: false
      t.boolean :requires_supervisor_justification, default: false, null: false
      t.boolean :requires_supervisor_supervisor_justification, default: false, null: false
      t.boolean :requires_approver_justification, default: false, null: false
      t.boolean :requires_approver_supervisor_justification, default: false, null: false

      t.timestamps
    end
  end
end

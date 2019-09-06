class CreateApprovers < ActiveRecord::Migration[5.1]
  def change
    create_table :approvers do |t|
      t.references :employee, foreign_key: {to_table: :next_sgad_employees}
      t.integer :kind, default: 0, null: false
      t.references :absence_type, foreign_key: true

      t.timestamps
    end
  end
end

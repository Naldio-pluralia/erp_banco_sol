class CreateObjectApprovers < ActiveRecord::Migration[5.1]
  def change
    create_table :object_approvers do |t|
      t.references :employee, foreign_key: {to_table: :next_sgad_employees}
      t.integer :kind, default: 0, null: false
      t.references :object, polymorphic: true

      t.timestamps
    end
  end
end

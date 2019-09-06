class CreateObjectResponses < ActiveRecord::Migration[5.1]
  def change
    create_table :object_responses do |t|
      t.references :employee, foreign_key: {to_table: :next_sgad_employees}
      t.references :object, polymorphic: true
      t.integer :status, default: 0, null: false
      t.integer :kind, default: 0, null: false

      t.timestamps
    end
  end
end

class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.references :employee, foreign_key: {to_table: :next_sgad_employees}
      t.string :name, null: false
      t.text :note, null: false

      t.timestamps
    end
  end
end

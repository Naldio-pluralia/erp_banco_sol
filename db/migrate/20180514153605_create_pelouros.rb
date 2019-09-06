class CreatePelouros < ActiveRecord::Migration[5.1]
  def change
    create_table :pelouros do |t|
      t.string :name, null: false
      t.string :abbreviation
      t.references :employee, foreign_key: {to_table: :next_sgad_employees}
      t.string :title
      t.string :title_abbreviation

      t.timestamps
    end
  end
end

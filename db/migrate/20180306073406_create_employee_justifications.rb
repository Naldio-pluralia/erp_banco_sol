class CreateEmployeeJustifications < ActiveRecord::Migration[5.1]
  def change
    create_table :employee_justifications do |t|
      t.references :employee, foreign_key: {to_table: :next_sgad_employees}
      t.json :attachments
      t.text :employee_note
      t.text :supervisor_note

      t.timestamps
    end
  end
end

class CreateJustificationAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :justification_answers do |t|
      t.references :employee_justification, foreign_key: true
      t.references :employee, foreign_key: {to_table: :next_sgad_employees}
      t.integer :status, default: 0, null: false
      t.integer :kind, default: 0, null: false

      t.timestamps
    end
  end
end

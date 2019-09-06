class CreateVacationApprovers < ActiveRecord::Migration[5.1]
  def change
    create_table :vacation_approvers do |t|
      t.references :employee, foreign_key: {to_table: :next_sgad_employees}

      t.timestamps
    end
  end
end

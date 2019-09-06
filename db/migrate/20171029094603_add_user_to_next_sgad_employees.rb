class AddUserToNextSgadEmployees < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :employee, foreign_key: {to_table: :next_sgad_employees}
  end
end

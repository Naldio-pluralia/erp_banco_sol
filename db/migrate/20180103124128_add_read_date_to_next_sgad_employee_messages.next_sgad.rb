# This migration comes from next_sgad (originally 20180103123801)
class AddReadDateToNextSgadEmployeeMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :next_sgad_employee_messages, :read_at, :datetime
  end
end

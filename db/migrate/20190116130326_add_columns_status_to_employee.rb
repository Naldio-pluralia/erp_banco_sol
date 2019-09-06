class AddColumnsStatusToEmployee < ActiveRecord::Migration[5.1]
  def change
    add_column :next_sgad_employees, :status, :integer, default: 0, null: false
  end
end

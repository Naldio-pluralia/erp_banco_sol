# This migration comes from next_sgad (originally 20180106144337)
class AddCanBeAssessedToNextSgadEmployees < ActiveRecord::Migration[5.1]
  def change
    add_column :next_sgad_employees, :can_be_assessed, :boolean, default: true, null: false
  end
end

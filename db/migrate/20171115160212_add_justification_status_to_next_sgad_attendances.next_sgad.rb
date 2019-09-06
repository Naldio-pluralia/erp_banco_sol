# This migration comes from next_sgad (originally 20171115160122)
class AddJustificationStatusToNextSgadAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :next_sgad_attendances, :justification_status, :integer, default: -1, null: false
  end
end

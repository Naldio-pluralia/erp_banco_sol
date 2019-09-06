# This migration comes from next_sgad (originally 20171112121440)
class AddStatusToNextSgadJustifications < ActiveRecord::Migration[5.1]
  def change
    add_column :next_sgad_justifications, :status, :integer, default: 0, null: false
    add_column :next_sgad_justifications, :employee_note, :text
    add_column :next_sgad_justifications, :supervisor_note, :text
  end
end

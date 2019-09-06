# This migration comes from next_sgad (originally 20171125001559)
class AddAprovedBySupervisorToNextSgadJustifications < ActiveRecord::Migration[5.1]
  def change
    add_column :next_sgad_justifications, :first_approval_status, :integer, default: 0, null: false
    add_column :next_sgad_justifications, :second_approval_status, :integer, default: 0, null: false
    add_column :next_sgad_employees, :can_approve_justifications, :boolean, default: false, null: false
  end
end

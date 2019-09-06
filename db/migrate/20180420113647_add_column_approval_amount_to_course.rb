class AddColumnApprovalAmountToCourse < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :approval_amount, :integer, default: 50, null: false
  end
end


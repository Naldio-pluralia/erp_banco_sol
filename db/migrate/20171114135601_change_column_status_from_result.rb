class ChangeColumnStatusFromResult < ActiveRecord::Migration[5.1]
  def change
    remove_column :next_sgad_results, :state
    add_column :next_sgad_results, :state, :integer, null: false, default: 0
  end
end

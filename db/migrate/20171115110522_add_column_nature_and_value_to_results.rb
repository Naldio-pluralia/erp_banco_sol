class AddColumnNatureAndValueToResults < ActiveRecord::Migration[5.1]
  def change
    add_column :next_sgad_results, :result_value,  :decimal, null: false, default: 0
    add_column :next_sgad_results, :result_nature, :integer, null: false, default: 0
    remove_column :next_sgad_results, :position_id
  end
end

class AddIsChairmanToPelouros < ActiveRecord::Migration[5.1]
  def change
    add_column :pelouros, :is_chairman, :boolean, default: false, null: false
  end
end

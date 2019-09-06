# This migration comes from next_sgad (originally 20171028061909)
class AddDescriptionToNextSgadFunctions < ActiveRecord::Migration[5.1]
  def change
    add_column :next_sgad_functions, :description, :text
  end
end

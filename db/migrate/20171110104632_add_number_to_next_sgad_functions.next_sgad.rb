# This migration comes from next_sgad (originally 20171110103155)
class AddNumberToNextSgadFunctions < ActiveRecord::Migration[5.1]
  def change
    add_column :next_sgad_functions, :number, :string
  end
end

class AddColumnsToNextSgadFunctions < ActiveRecord::Migration[5.1]
  def change
    add_column :next_sgad_functions, :enters_at, :time
    add_column :next_sgad_functions, :leaves_at, :time
    add_column :next_sgad_functions, :qualification_kind, :integer, default: 0, null: false
    add_column :next_sgad_functions, :objectives, :text
    add_column :next_sgad_functions, :other_requirements, :text
    add_reference :next_sgad_functions, :function_contract_type, foreign_key: true
    add_reference :next_sgad_functions, :function_deslocation_regime, foreign_key: true
    add_column :next_sgad_functions, :experience_kind, :integer, default: 0, null: false
    add_column :next_sgad_functions, :experience_years, :integer, default: 0, null: false
  end
end

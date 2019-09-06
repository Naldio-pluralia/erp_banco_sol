class JoinTables < ActiveRecord::Migration[5.1]
  def change
    create_join_table :subsidy_types, :next_sgad_functions do |t|
      t.index [:subsidy_type_id, :next_sgad_function_id], name: 'indx_funcns_suby_types_on_subsidy_type_id_and_function_id'
    end
    
    create_join_table :subsidy_types, :next_sgad_positions do |t|
      t.index [:subsidy_type_id, :next_sgad_position_id], name: 'index_positns_subsidy_types_on_subsidy_type_id_and_position_id'
    end
    
    create_join_table :tax_types, :next_sgad_functions do |t|
      t.index [:tax_type_id, :next_sgad_function_id], name: 'index_functions_tax_types_on_tax_type_id_and_function_id'
    end
    
    create_join_table :tax_types, :next_sgad_positions do |t|
      t.index [:tax_type_id, :next_sgad_position_id], name: 'index_positions_tax_types_on_tax_type_id_and_position_id'
    end
  end
end

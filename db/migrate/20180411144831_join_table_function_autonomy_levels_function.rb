class JoinTableFunctionAutonomyLevelsFunction < ActiveRecord::Migration[5.1]
  def change
    create_join_table :function_autonomy_levels, :next_sgad_functions do |t|
      t.index [:function_autonomy_level_id, :next_sgad_function_id], name: 'idx_tnmy_lvls_n_fnctn_my_lvl_d_nd_fnctn_d'
    end
    create_join_table :function_subsidies, :next_sgad_functions do |t|
      t.index [:function_subsidy_id, :next_sgad_function_id], name: 'ndx_fnctn_rs_fnctns_n_fnctn_r_d_nd_fnctn_d'
    end
    create_join_table :function_areas, :next_sgad_functions do |t|
      t.index [:function_area_id, :next_sgad_function_id], name: 'ndx_fnctn_rs_fnctns_n_fnctn_r_d_and_fnctn_d'
    end
  end
end

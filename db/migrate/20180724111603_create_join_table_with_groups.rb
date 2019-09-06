class CreateJoinTableWithGroups < ActiveRecord::Migration[5.1]
  def change
    create_join_table :groups, :next_sgad_employees do |t|
      t.index [:group_id, :next_sgad_employee_id], name: 'index_employees_groups_on_group_id_and_employee_id'
    end

    create_join_table :groups, :next_sgad_positions do |t|
      t.index [:group_id, :next_sgad_position_id], name: 'index_positions_groups_on_group_id_and_position_id'
    end

    create_join_table :groups, :next_sgad_functions do |t|
      t.index [:group_id, :next_sgad_function_id], name: 'index_functions_groups_on_group_id_and_function_id'
    end
  end
end

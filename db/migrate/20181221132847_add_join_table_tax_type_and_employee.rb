class AddJoinTableTaxTypeAndEmployee < ActiveRecord::Migration[5.1]
  def change
    create_join_table :tax_types, :next_sgad_employees do |t|
      t.index [:tax_type_id, :next_sgad_employee_id], name: 'index_employee_tax_types_on_tax_type_id_and_employee_id'
    end

    create_join_table :subsidy_types, :next_sgad_employees do |t|
      t.index [:subsidy_type_id, :next_sgad_employee_id], name: 'index_employee_tax_types_on_subsidy_type_id_and_employee_id'
    end
  end
end

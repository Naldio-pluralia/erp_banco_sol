class ResoltsRelationship < ActiveRecord::Migration[5.1]
  def change
    add_reference :next_sgad_results, :employee,        foreign_key: {to_table: :next_sgad_employees},      index: true
    add_reference :next_sgad_results, :position,        foreign_key: {to_table: :next_sgad_positions},      index: true
    add_reference :next_sgad_results, :assessment,      foreign_key: {to_table: :next_sgad_assessments},    index: true
    add_reference :next_sgad_results, :employee_goal,   foreign_key: {to_table: :next_sgad_employee_goals}, index: true
    add_reference :next_sgad_results, :goal,            foreign_key: {to_table: :next_sgad_goals},          index: true
  end
end

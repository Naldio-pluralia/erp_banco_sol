class AddOrganicUnitToFunction < ActiveRecord::Migration[5.1]
  def change
    add_reference :next_sgad_functions, :organic_unit, foreign_key: {to_table: :organic_units}, index: true
  end
end

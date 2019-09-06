class AddEstablishmentsReferenceToEstablishments < ActiveRecord::Migration[5.1]
  def change
    add_reference :establishments, :establishment, foreign_key: true
    add_reference :organic_units, :organic_unit, foreign_key: true
    add_reference :next_sgad_positions, :organic_unit, foreign_key: {to_table: :organic_units}, index: true
    add_reference :next_sgad_positions, :establishment, foreign_key: {to_table: :establishments}, index: true
  end
end

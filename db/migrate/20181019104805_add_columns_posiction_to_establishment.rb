class AddColumnsPosictionToEstablishment < ActiveRecord::Migration[5.1]
  def change
    add_reference :establishments, :position, foreign_key: {to_table: :next_sgad_positions}, index: true
  end
end

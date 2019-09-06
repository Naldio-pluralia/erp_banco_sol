class AddColunasDoQualificador < ActiveRecord::Migration[5.1]
  def change
    add_reference :next_sgad_functions, :directorate, foreign_key: {to_table: :directorates}
  end
end

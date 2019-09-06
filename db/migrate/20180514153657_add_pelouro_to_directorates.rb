class AddPelouroToDirectorates < ActiveRecord::Migration[5.1]
  def change
    add_reference :directorates, :pelouro, foreign_key: true
  end
end

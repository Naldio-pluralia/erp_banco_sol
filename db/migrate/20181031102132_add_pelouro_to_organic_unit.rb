class AddPelouroToOrganicUnit < ActiveRecord::Migration[5.1]
  def change
    add_reference :organic_units, :pelouro, foreign_key: true
  end
end

class CreateSalaryAreas < ActiveRecord::Migration[5.1]
  def up
    create_table :salary_areas do |t|
      t.string :name, null: false

      t.timestamps
    end
    SalaryArea.create([{name: 'Auxiliar'}, {name: 'Comercial'}, {name: 'Operacional'}]).each{|s| p s.errors.messages; p s}
  end

  def down
    drop_table :salary_areas
  end
end

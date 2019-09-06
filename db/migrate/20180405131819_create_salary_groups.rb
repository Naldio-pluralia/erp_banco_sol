class CreateSalaryGroups < ActiveRecord::Migration[5.1]
  def up
    create_table :salary_groups do |t|
      t.string :name, null: false

      t.timestamps
    end
    SalaryGroup.create([{name: 'Coordenação | Departamento'}, {name: 'Supervisão'}, {name: 'Execução | Supervisão'}, {name: 'Execução'}]).each{|s| p s.errors.messages; p s}
  end

  def down
    drop_table :salary_groups
  end
end

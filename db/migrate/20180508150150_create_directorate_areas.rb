class CreateDirectorateAreas < ActiveRecord::Migration[5.1]
  def up
    create_table :directorate_areas do |t|
      t.string :name, null: false

      t.timestamps
    end
    areas = ['Negócio', 'Controlo', 'Operações', 'Administração', 'Comissões']
    p DirectorateArea.create(areas.map{|f| {name: f}}).map{|f| [f, f.errors.messages]}
  end

  def down
    drop_table :directorate_areas
  end
end

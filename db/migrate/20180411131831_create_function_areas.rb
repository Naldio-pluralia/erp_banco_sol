class CreateFunctionAreas < ActiveRecord::Migration[5.1]
  def change
    create_table :function_areas do |t|
      t.string :name

      t.timestamps
    end
    array = ['Negócio', 'Controlo', 'Operações', 'Administração', 'Comissões']
    p FunctionArea.create(array.map{|l| {name: l}}).each{|f| [f, f.errors.messages]}
  end

  def down
    drop_table :function_areas
  end
end

class CreateFunctionSubsidies < ActiveRecord::Migration[5.1]
  def change
    create_table :function_subsidies do |t|
      t.string :name

      t.timestamps
    end
    array = ['Subsídio de Função', 'Subsídio de Transporte', 'Abono de Falhas', 'Subsídio de Representação', 'Isenção de Horário de Trabalho']
    p FunctionSubsidy.create(array.map{|l| {name: l}}).each{|f| [f, f.errors.messages]}
  end

  def down
    drop_table :function_subsidies
  end
end

class CreateFunctionContractTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :function_contract_types do |t|
      t.string :name

      t.timestamps
    end
    array = ['Termo Certo', 'Indeterminado', 'Prestação de Serviços']
    p FunctionContractType.create(array.map{|l| {name: l}}).each{|f| [f, f.errors.messages]}
  end

  def down
    drop_table :function_contract_types
  end
end

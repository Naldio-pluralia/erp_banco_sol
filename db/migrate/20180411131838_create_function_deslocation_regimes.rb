class CreateFunctionDeslocationRegimes < ActiveRecord::Migration[5.1]
  def change
    create_table :function_deslocation_regimes do |t|
      t.string :name

      t.timestamps
    end
    array = ['De acordo com o plano actual em vigor']
    p FunctionDeslocationRegime.create(array.map{|l| {name: l}}).each{|f| [f, f.errors.messages]}
  end

  def down
    drop_table :function_deslocation_regimes
  end
end

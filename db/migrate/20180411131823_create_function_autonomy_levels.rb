class CreateFunctionAutonomyLevels < ActiveRecord::Migration[5.1]
  def up
    create_table :function_autonomy_levels do |t|
      t.string :name

      t.timestamps
    end

    base = RemunerationSetting.last&.base_salary || 0
    update_factor = RemunerationSetting.last&.update_factor || 0
    (1..17).each do |number|
      p SalaryGrid.create(number: number, code: 1, value_80: base.x_percent(80).round, value_100: base, value_110: base.x_percent(110).round, value_125: base.x_percent(125).round)
      base = base.plus_x_percent(update_factor).x_percent(100, 80).round
    end
    levels = ['Planeamento e Organização de Trabalhos de Terceiros', 'Tomada de Decisão', 'Emissão de Pareceres', 'Autonomia de Execução de Património', 'Movimentação de Valores Monetários Simples']
    p FunctionAutonomyLevel.create(levels.map{|l| {name: l}}).each{|f| [f, f.errors.messages]}
  end

  def down
    drop_table :function_autonomy_levels
  end
end

class CreateSalaryLayers < ActiveRecord::Migration[5.1]
  def up
    create_table :salary_layers do |t|
      t.string :name, null: false

      t.timestamps
    end
    SalaryLayer.create([{name: 'Superior'}, {name: 'Supervisor'}, {name: 'Especialista'}, {name: 'Sénior'}, {name: 'Pleno'}, {name: 'Assistente'}, {name: 'Júnior'}]).each{|s| p s.errors.messages; p s}
  end

  def down
    drop_table :salary_layers
  end
end

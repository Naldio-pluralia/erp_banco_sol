class CreateEmployeeSkills < ActiveRecord::Migration[5.1]
  def up
    create_table :employee_skills do |t|
      t.references :skill, foreign_key: true
      t.references :employee, foreign_key: {to_table: :next_sgad_employees}
      t.decimal :value, default: 0, null: false

      t.timestamps
    end
    array = [
      'Gestão de Tempo',
      'Domínio de Procedimentos Internos e Externos',
      'Adaptabilidade', 'Proactividade e Iniciativa',
      'Comprometimento e Orientação para Resultados',
      'Planeamento e Organização',
      'Relacionamento Interpessoal',
      'Serviço ao Cliente',
      'Trabalho em Equipa',
      'Capacidade de Comunicar de Forma Eficaz e Eficiente',
      'Saber Escutar',
      'Ética e Sigilo Profissional',
      'Auto-Controle Emocianal',
      'Capacidade de Desenvolvimento Pessoal',
      'Domínio dos Normativos e Leis',
      'Domínio de Redes e Sistemas Informáticos',
      'Liderança de Equipa',
      'Capacidade Investigativa',
      'Tomada de Decisão',
      'Domínio de Segurança de Dados Eletrónicos',
      'Domínio de Ferramentas Tecnológicas(MSOffice)',
      'Domínio de L. Estrangeiras',
      'Domínio de L. Portuguesa',
      'Conhecimento de Plataformas de TI e Canais de Comunicação',
      'Sistemas e Meios de Pagamentos',
      'Gestão de Reclamações',
      'Técnicas e Controle de Fraudes'
    ]
    p Skill.create(array.map{|l| {name: l}}).each{|f| [f, f.errors.messages]}
  end

  def down
    drop_table :employee_skills
  end
end

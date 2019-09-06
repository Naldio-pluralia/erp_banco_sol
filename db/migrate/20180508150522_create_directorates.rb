class CreateDirectorates < ActiveRecord::Migration[5.1]
  def up
    create_table :directorates do |t|
      t.string :name, null: false
      t.references :directorate_area, foreign_key: true
      t.string :abbreviation, null: false

      t.timestamps
    end
    direccoes = [
      {name: "Direcção NEGÓCIOS INTERNACIONAIS", abbreviation: "DNI", area: "Negócio"},
      {name: "Direcção GRANDES EMPRESAS", abbreviation: "DGE", area: "Negócio"},
      {name: "Direcção PEQUENAS E MÉDIAS EMPRESAS", abbreviation: "DPME", area: "Negócio"},
      {name: "Direcção PARTICULARES", abbreviation: "DPT", area: "Negócio"},
      {name: "Direcção PRIVATE", abbreviation: "PRIVATE", area: "Negócio"},
      {name: "Direcção MICROCRÉDITO", abbreviation: "DMC", area: "Negócio"},
      {name: "Direcção BANCA DE INVESTIMENTO", abbreviation: "DBI", area: "Negócio"},
      {name: "Direcção BANCASSURANCE", abbreviation: "DBA", area: "Negócio"},
      {name: "Direcção PRODUTOS ESPECIALIZADOS", abbreviation: "DPE", area: "Negócio"},
      {name: "Direcção AUDITORIA INTERNA", abbreviation: "DAI", area: "Controlo"},
      {name: "Direcção COMPLIANCE", abbreviation: "DCP", area: "Controlo"},
      {name: "Direcção GESTÃO DE RISCO", abbreviation: "DGR", area: "Controlo"},
      {name: "Direcção RECURSOS HUMANOS", abbreviation: "RH", area: "Operações"},
      {name: "Direcção DESENVOLVIMENTO INSTITUCIONAL", abbreviation: "DDI", area: "Operações"},
      {name: "Direcção RELAÇÕES INSTITUCIONAIS E CORPORATIVAS", abbreviation: "DRI", area: "Operações"},
      {name: "Direcção OPERAÇÕES", abbreviation: "DOP", area: "Operações"},
      {name: "Direcção ANÁLISE E PROCESSAMENTO DE CRÉDITO", abbreviation: "DAPC", area: "Operações"},
      {name: "Direcção GESTÃO E RECUPERAÇÃO CRÉDITO", abbreviation: "DGR", area: "Operações"},
      {name: "Direcção FINANCEIRA", abbreviation: "DFI", area: "Operações"},
      {name: "Direcção TECNOLOGIAS E SISTEMAS DE INFORMAÇÃO", abbreviation: "DTI", area: "Operações"},
      {name: "Direcção BANCA ELECTRÓNICA", abbreviation: "DBE", area: "Operações"},
      {name: "Direcção MARKETING E COMUNICAÇÃO", abbreviation: "DMK", area: "Operações"},
      {name: "Direcção CONTABILIDADE", abbreviation: "DCO", area: "Operações"},
      {name: "Direcção JURÍDICA", abbreviation: "JURIDICA", area: "Operações"},
      {name: "Direcção SEGURANÇA, PATRIMÓNIO E SERVIÇOS", abbreviation: "DPS", area: "Operações"}
    ]
    areas = DirectorateArea.all.index_by(&:name)
    p Directorate.create(direccoes.map{|f| {name: f[:name].to_s.next_titleize, abbreviation: f[:abbreviation], directorate_area_id: areas[f[:area]]&.id} }).map{|f| [f, f.errors.messages]}
  end

  def down
    drop_table :directorates
  end
end

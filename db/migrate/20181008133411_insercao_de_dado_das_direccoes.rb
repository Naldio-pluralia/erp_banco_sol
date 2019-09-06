class InsercaoDeDadoDasDireccoes < ActiveRecord::Migration[5.1]
  def change

    direccao      = OrganicUnitType.create(name: 'Direcção')

    direccoes = [
      {organic_unit_type_id: direccao.id, abbreviation: 'DJU', name: 'Direcção de Jurídica'},
      {organic_unit_type_id: direccao.id, abbreviation: 'DPM', name: 'Direcção de Pequenas, Médias Empresas e Particulares'},
      {organic_unit_type_id: direccao.id, abbreviation: 'DGE', name: 'Direcção de Grandes Empresas e Particulares'},
      {organic_unit_type_id: direccao.id, abbreviation: 'DRC', name: 'Direcção de Risco'},
      {organic_unit_type_id: direccao.id, abbreviation: 'DCO', name: 'Direcção de Contabilidade'},
      {organic_unit_type_id: direccao.id, abbreviation: 'DFI', name: 'Direcção de Financeira'},
      {organic_unit_type_id: direccao.id, abbreviation: 'DOP', name: 'Direcção de Operações'},
      {organic_unit_type_id: direccao.id, abbreviation: 'DPS', name: 'Direcção de Património e Serviços'},
      {organic_unit_type_id: direccao.id, abbreviation: 'DPE', name: 'Direcção de Pessoal'},
      {organic_unit_type_id: direccao.id, abbreviation: 'DDI', name: 'Direcção de Desenvolvimento Institucional'},
      {organic_unit_type_id: direccao.id, abbreviation: 'DPC', name: 'Direcção de Processamento e Controlo de Crédito'},
      {organic_unit_type_id: direccao.id, abbreviation: 'DMC', name: 'Direcção de Microcrédito'},
      {organic_unit_type_id: direccao.id, abbreviation: 'DTI', name: 'Direcção de Tecnologia e Sistemas de Informação'},
      {organic_unit_type_id: direccao.id, abbreviation: 'DMK', name: 'Direcção de Marketing e Comunicação'},
      {organic_unit_type_id: direccao.id, abbreviation: 'DGR', name: 'Direcção de Gestão e Recuperação de Crédito'},
      {organic_unit_type_id: direccao.id, abbreviation: 'DNI', name: 'Direcção de Desenvolvimento de Negócios Internacionais'},
      {organic_unit_type_id: direccao.id, abbreviation: 'DAI', name: 'Direcção de Auditoria Interna'},
      {organic_unit_type_id: direccao.id, abbreviation: 'DCP', name: 'Direcção de Compliance'},
      {organic_unit_type_id: direccao.id, abbreviation: 'DCE', name: 'Direcção de Risco de Crédito'},
      {organic_unit_type_id: direccao.id, abbreviation: 'DBE', name: 'Direcção de Banca Electronica'},
      {organic_unit_type_id: direccao.id, abbreviation: 'DBI', name: 'Direcção de Banca de Investimentos'},
      {organic_unit_type_id: direccao.id, abbreviation: 'DPB', name: 'Direcção de Private Banking'},
      {organic_unit_type_id: direccao.id, abbreviation: 'DTS', name: 'Direcção de Tesouraria'},
      {organic_unit_type_id: direccao.id, abbreviation: 'DSG', name: 'Direcção de Segurança'	}
    ]

      directorate = OrganicUnit.create(direccoes)
      p directorate
  end
end

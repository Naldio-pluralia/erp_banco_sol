class InsercaoDeDadosDoDepartamento < ActiveRecord::Migration[5.1]
  def change

        # if column_exists?(:next_sgad_departments, :next_sgad_department_id)
        #   remove_reference :next_sgad_departments, :next_sgad_department, foreign_key: true
        # end
        departamento  = OrganicUnitType.create(name: 'Departamento')
        # if column_exists?(:next_sgad_departments, :department_id)
        #   #remove_reference :departments, :department, foreign_key: true
        #   remove_column :next_sgad_departments, :department_id
        # end

        department = [
          {organic_unit_type_id: departamento.id, abbreviation: "RSE", name: "Departamento Seguros e Produtos Especializados"},
          {organic_unit_type_id: departamento.id, abbreviation: "RDC", name: "Departamento Dinamização Comercial"},
          {organic_unit_type_id: departamento.id, abbreviation: "RPD", name: "Departamento Preparação Documental"},
          {organic_unit_type_id: departamento.id, abbreviation: "RPR", name: "Departamento Processamento de Dados"},
          {organic_unit_type_id: departamento.id, abbreviation: "RAN", name: "Departamento Análise de Crédito"},
          {organic_unit_type_id: departamento.id, abbreviation: "RFE", name: "Departamento Financiamentos Estruturado Contratação"},
          {organic_unit_type_id: departamento.id, abbreviation: "RSF", name: "Departamento Segurança Física"},
          {organic_unit_type_id: departamento.id, abbreviation: "RSL", name: "Departamento Segurança Electrónica"},
          {organic_unit_type_id: departamento.id, abbreviation: "RSN", name: "Departamento Segurança da Informação"},
          {organic_unit_type_id: departamento.id, abbreviation: "ROP", name: "Departamento Operacional"},
          {organic_unit_type_id: departamento.id, abbreviation: "RCG", name: "Departamento Controlo e Gestão"},
          {organic_unit_type_id: departamento.id, abbreviation: "RIG", name: "Departamento Informação de Gestão"},
          {organic_unit_type_id: departamento.id, abbreviation: "RRF", name: "Departamento Riscos Financeiros"},
          {organic_unit_type_id: departamento.id, abbreviation: "RRN", name: "Departamento Riscos Não Financeiros"},
          {organic_unit_type_id: departamento.id, abbreviation: "RSM", name: "Departamento da Sala de Mercados"},
          {organic_unit_type_id: departamento.id, abbreviation: "RCR", name: "Departamento Controlo Financeiro e Risco"},
          {organic_unit_type_id: departamento.id, abbreviation: "RON", name: "Departamento Operações Nacionais"},
          {organic_unit_type_id: departamento.id, abbreviation: "ROE", name: "Departamento Operações de Estrangeiro"},
          {organic_unit_type_id: departamento.id, abbreviation: "RMT", name: "Departamento Manutenção de Contas"},
          {organic_unit_type_id: departamento.id, abbreviation: "RCO", name: "Departamento Controlo Operacional"},
          {organic_unit_type_id: departamento.id, abbreviation: "RGO", name: "Departamento Gestão de Projectos de Obras"},
          {organic_unit_type_id: departamento.id, abbreviation: "RTE", name: "Departamento Transporte"},
          {organic_unit_type_id: departamento.id, abbreviation: "RSV", name: "Departamento Serviços"},
          {organic_unit_type_id: departamento.id, abbreviation: "RES", name: "Departamento Manutenção de Balcões, Controlo e Supervisão"},
          {organic_unit_type_id: departamento.id, abbreviation: "RPA", name: "Departamento Património"},
          {organic_unit_type_id: departamento.id, abbreviation: "RRS", name: "Departamento Recrutamento e  Selecção"},
          {organic_unit_type_id: departamento.id, abbreviation: "RGP", name: "Departamento Gestão e Processamento"},
          {organic_unit_type_id: departamento.id, abbreviation: "RFD", name: "Departamento Formação e Desenvolvimento do Capital Humano"},
          {organic_unit_type_id: departamento.id, abbreviation: "ROG", name: "Departamento Organizacional"},
          {organic_unit_type_id: departamento.id, abbreviation: "RQL", name: "Departamento Qualidade"},
          {organic_unit_type_id: departamento.id, abbreviation: "RAM", name: "Departamento Análise e Monitorização"},
          {organic_unit_type_id: departamento.id, abbreviation: "RPO", name: "Departamento Processamento e Operações"},
          {organic_unit_type_id: departamento.id, abbreviation: "RSI", name: "Departamento Sistemas"},
          {organic_unit_type_id: departamento.id, abbreviation: "RRC", name: "Departamento Redes e Comunicações"},
          {organic_unit_type_id: departamento.id, abbreviation: "RAP", name: "Departamento Apoio a Utilizadores"},
          {organic_unit_type_id: departamento.id, abbreviation: "RDS", name: "Departamento Desenvolvimentode sistemas Aplicacionais"},
          {organic_unit_type_id: departamento.id, abbreviation: "RIM", name: "Departamento Instalação de Manutenção de Equipamento Informático"},
          {organic_unit_type_id: departamento.id, abbreviation: "ROS", name: "Departamento Operação de Sistemas Centrais"},
          {organic_unit_type_id: departamento.id, abbreviation: "RGT", name: "Departamento Gestão de Projectos de Tecnologias de Informação"},
          {organic_unit_type_id: departamento.id, abbreviation: "RCE", name: "Departamento Centros"},
          {organic_unit_type_id: departamento.id, abbreviation: "RRE", name: "Departamento Recuperação de Crédito"},
          {organic_unit_type_id: departamento.id, abbreviation: "RRI", name: "Departamento Recuperação de Microcrédito"},
          {organic_unit_type_id: departamento.id, abbreviation: "RAJ", name: "Departamento Assessoria Juridica"},
          {organic_unit_type_id: departamento.id, abbreviation: "RCN", name: "Departamento Contencioso"},
          {organic_unit_type_id: departamento.id, abbreviation: "RPC", name: "Departamento Provedoria de Cliente"},
          {organic_unit_type_id: departamento.id, abbreviation: "RMK", name: "Departamento Marketing"},
          {organic_unit_type_id: departamento.id, abbreviation: "RPS", name: "Departamento Produtos e Serviços"},
          {organic_unit_type_id: departamento.id, abbreviation: "RAC", name: "Departamento Aceitação"},
          {organic_unit_type_id: departamento.id, abbreviation: "RCF", name: "Departamento Controlo e Fraude"},
          {organic_unit_type_id: departamento.id, abbreviation: "RAB", name: "Departamento Auditoria  aos Balcões"},
          {organic_unit_type_id: departamento.id, abbreviation: "RAS", name: "Departamento Auditoria aos Serviços Centrais"},
          {organic_unit_type_id: departamento.id, abbreviation: "RAU", name: "Departamento Auditoria Remota"},
          {organic_unit_type_id: departamento.id, abbreviation: "RCU", name: "Departamento Controlo de Numerário"},
          {organic_unit_type_id: departamento.id, abbreviation: "RCP", name: "Departamento Contagem e Pagamentos"},
          {organic_unit_type_id: departamento.id, abbreviation: "RFO", name: "Departamento Conformidade"},
          {organic_unit_type_id: departamento.id, abbreviation: "RPB", name: "Departamento Prevenção de Branqueamento de Capitais"},
          {organic_unit_type_id: departamento.id, abbreviation: "RBA", name: "Departamento Balcões"}
        ]


        departments = OrganicUnit.create(department)

        p departments
  end
end

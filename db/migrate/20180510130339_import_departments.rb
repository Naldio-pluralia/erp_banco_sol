class ImportDepartments < ActiveRecord::Migration[5.1]
  def up
    data = [
     "Centro Empresas",
     "Centro Empresas",
     "Análise e Monitorização",
     "Análise e Monitorização",
     "Processamento",
     "Processamento",
     "Gestão Produto e Protocolos",
     "Gestão Produto e Protocolos",
     "Serviços Centrais",
     "Balcões",
     "Balcões",
     "Auditoria Remota",
     "Auditoria Remota",
     "Controlo Interno",
     "Controlo Interno",
     "BC e FT",
     "BC e FT",
     "Analise de Risco de Crédito",
     "Análise de Risco de Crédito",
     "Análise de Risco Operacional",
     "Análise de Risco Operacional",
     "Gestão e Processamento",
     "Gestão e Processamento",
     "Formação e Desenvov. Capital H",
     "Formação e Desenvov. Capital H",
     "Selecção e Recrutamento",
     "Selecção e Recrutamento",
     "Organizacional",
     "Organizacional",
     "Qualidade",
     "Qualidade",
     "ON",
     "ON",
     "OE",
     "OE",
     "MC",
     "MC",
     "PROCESSAMENTO CRÉDITO",
     "PROCESSAMENTO CRÉDITO",
     "Análise de Crédito",
     "Análise de Crédito",
     "Crédito Estruturado",
     "Crédito Estruturado",
     "Contratação",
     "Contratação",
     "Gestão de Informação",
     "Gestão de Informação",
     "Controlo Operacções",
     "Controlo Operacções",
     "Controlo Operacções",
     "Controlo Operacções",
     "Tesouraria",
     "Tesouraria",
     "Sala Mercados",
     "Sala Mercados",
     "Controlo Operacções",
     "Controlo Operacções",
     "Aceitação",
     "Aceitação",
     "Controlo e Fraudes",
     "Controlo e Fraudes",
     "Produtos e Serviços",
     "Produtos e Serviços",
     "Call Center",
     "Call Center",
     "Comunicação e Imagem",
     "Comunicação e Imagem",
     "Protocolo e Relações Públicas",
     "Protocolo e Relações Públicas",
     "CRM",
     "CRM",
     "Operacional",
     "Operacional",
     "Controlo Orçamental",
     "Controlo Orçamental",
     "Informação Gestão",
     "Informação Gestão",
     "Acessoria Juridica",
     "CN?",
     "Gestão Obras",
     "Património",
     "Segurança",
     "Serviços",
     "Economato",
     "Transporte",
     "Correspondencia",
    ]
    data = data.map{|f| {name: f}}
    Department.create(data)
  end

  def down
    
  end
end

class AddSomeAbsenceTypes < ActiveRecord::Migration[5.1]
  def up
  absence_types = [
    # Absence
    {name: 'Férias', kind: :absence, code: 0, requires_document: true, requires_justification: false, requires_supervisor_justification: false, requires_supervisor_supervisor_justification: false, requires_approver_justification: false, requires_approver_supervisor_justification: false, description: 'Ausência correspondente ao gozo de dias de férias. A ausência deve estar de acordo com o Plano Anual de Férias. Qualquer marcação de férias que não esteja de acordo com o Plano Anual deve ser indicado qual(is) o(s) período(s) que se pretende alterar'},
    {name: 'Doença do Trabalhador', kind: :absence, code: 0, requires_document: true, requires_justification: true, requires_supervisor_justification: true, requires_supervisor_supervisor_justification: true, requires_approver_justification: true, requires_approver_supervisor_justification: true, description: 'estão incluídas todas as Ausências por Doença súbita do Trabalhador com exceção das ausências relacionadas com Junta Médica (Baixa por Doença). Estas ausências devem ser justificadas através de atestado médico ou justificação passada pelo centro médico ou unidade hospitalar;'},
    {name: 'Consulta Médica do Trabalhador', kind: :absence, code: 0, requires_document: true, requires_justification: true, requires_supervisor_justification: true, requires_supervisor_supervisor_justification: true, requires_approver_justification: true, requires_approver_supervisor_justification: true, description: 'ausências relacionadas com consultas e exames de rotina do trabalhador. Estas ausências devem ser justificadas através de atestado médico ou justificação de presença passada pelo centro médico ou unidade hospitalar;'},
    {name: 'Assistência de familiar', kind: :absence, code: 0, requires_document: true, requires_justification: true, requires_supervisor_justification: true, requires_supervisor_supervisor_justification: true, requires_approver_justification: true, requires_approver_supervisor_justification: true, description: 'ausências relacionadas com a necessidade da prestação de assistência inadiável e imprescindível a membros do agregado familiar ou consultas/exames de rotina de filhos em idade escolar. Estas ausências devem ser justificadas através de atestado médico ou justificação de presença passada pelo centro médico ou unidade hospitalar;'},
    {name: 'Licença de Casamento', kind: :absence, code: 0, requires_document: true, requires_justification: true, requires_supervisor_justification: true, requires_supervisor_supervisor_justification: true, requires_approver_justification: true, requires_approver_supervisor_justification: true, description: 'ausência relacionada com o casamento do trabalhador. Estas ausências devem ser justificadas através da apresentação do averbamento do casamento;'},
    {name: 'Licença de Maternidade e Paternidade', kind: '', code: 0, requires_document: true, requires_justification: true, requires_supervisor_justification: true, requires_supervisor_supervisor_justification: true, requires_approver_justification: true, requires_approver_supervisor_justification: true, description: 'ausência relacionada com o nascimento de filhos. Estas ausências devem ser justificadas através da apresentação da cédula de nascimento ou justificação de presença passada pelo centro médico ou unidade hospitalar;'},
    {name: 'Funeral', kind: :absence, code: 0, requires_document: true, requires_justification: true, requires_supervisor_justification: true, requires_supervisor_supervisor_justification: true, requires_approver_justification: true, requires_approver_supervisor_justification: true, description: 'ausência relacionada com o óbito de familiar do trabalhador. Estas ausências devem ser justificadas através da apresentação da certidão de óbito ou justificação de presença passada pelo serviço funerário;'},
    {name: 'Baixa por acidente de trabalho e doença de trabalhador', kind: :absence, code: 0, requires_document: true, requires_justification: true, requires_supervisor_justification: true, requires_supervisor_supervisor_justification: true, requires_approver_justification: true, requires_approver_supervisor_justification: true, description: 'todas as ausências que sejam atribuídas por junta médica na sequência de doença ou acidente de trabalho do trabalhador. Estas ausências devem ser justificadas através da apresentação do relatório da junta médica;'},
    {name: 'Obrigações Legais:', kind: :absence, code: 0, requires_document: true, requires_justification: true, requires_supervisor_justification: true, requires_supervisor_supervisor_justification: true, requires_approver_justification: true, requires_approver_supervisor_justification: true, description: 'Ausências relacionadas com motivos legais ou militares (exemplo: presenças em tribunal, cumprimento de obrigações militares, etc.). Estas ausências devem ser justificadas através da apresentação da justificação de presença passada pela entidade;'},
    {name: 'Assuntos de Sindicato', kind: :absence, code: 0, requires_document: true, requires_justification: true, requires_supervisor_justification: true, requires_supervisor_supervisor_justification: true, requires_approver_justification: true, requires_approver_supervisor_justification: true, description: 'ausência relacionada com a actividade sindical dos trabalhadores com cargos e funções sindicais. Estas ausências devem ser justificadas pela apresentação da justificação de presença passada pelo sindicato;'},
    {name: 'Outros Motivos', kind: :absence, code: 0, requires_document: true, requires_justification: true, requires_supervisor_justification: true, requires_supervisor_supervisor_justification: true, requires_approver_justification: true, requires_approver_supervisor_justification: true, description: 'ausências relacionadas com motivos não tipificados nas anteriores. Para o efeito, devem indicar qual o motivo da ausência no espaço reservado para o efeito. Sempre que possível, estas ausências devem ser justificadas com apresentação de documento comprovativo.'},
    # delays
    {name: 'Doença do Trabalhador', kind: :delay, code: 0, requires_document: true, requires_justification: true, requires_supervisor_justification: true, requires_supervisor_supervisor_justification: true, requires_approver_justification: true, requires_approver_supervisor_justification: true, description: 'estão incluídas todas as Ausências por Doença súbita do Trabalhador com exceção das ausências relacionadas com Junta Médica (Baixa por Doença). Estas ausências devem ser justificadas através de atestado médico ou justificação passada pelo centro médico ou unidade hospitalar;'},
    {name: 'Consulta Médica do Trabalhador', kind: :delay, code: 0, requires_document: true, requires_justification: true, requires_supervisor_justification: true, requires_supervisor_supervisor_justification: true, requires_approver_justification: true, requires_approver_supervisor_justification: true, description: 'ausências relacionadas com consultas e exames de rotina do trabalhador. Estas ausências devem ser justificadas através de atestado médico ou justificação de presença passada pelo centro médico ou unidade hospitalar;'},
    {name: 'Assistência de familiar', kind: :delay, code: 0, requires_document: true, requires_justification: true, requires_supervisor_justification: true, requires_supervisor_supervisor_justification: true, requires_approver_justification: true, requires_approver_supervisor_justification: true, description: 'ausências relacionadas com a necessidade da prestação de assistência inadiável e imprescindível a membros do agregado familiar ou consultas/exames de rotina de filhos em idade escolar. Estas ausências devem ser justificadas através de atestado médico ou justificação de presença passada pelo centro médico ou unidade hospitalar;'},
    {name: 'Funeral', kind: :delay, code: 0, requires_document: true, requires_justification: true, requires_supervisor_justification: true, requires_supervisor_supervisor_justification: true, requires_approver_justification: true, requires_approver_supervisor_justification: true, description: 'ausência relacionada com o óbito de familiar do trabalhador. Estas ausências devem ser justificadas através da apresentação da certidão de óbito ou justificação de presença passada pelo serviço funerário;'},
    {name: 'Obrigações Legais:', kind: :delay, code: 0, requires_document: true, requires_justification: true, requires_supervisor_justification: true, requires_supervisor_supervisor_justification: true, requires_approver_justification: true, requires_approver_supervisor_justification: true, description: 'Ausências relacionadas com motivos legais ou militares (exemplo: presenças em tribunal, cumprimento de obrigações militares, etc.). Estas ausências devem ser justificadas através da apresentação da justificação de presença passada pela entidade;'},
    {name: 'Assuntos de Sindicato', kind: :delay, code: 0, requires_document: true, requires_justification: true, requires_supervisor_justification: true, requires_supervisor_supervisor_justification: true, requires_approver_justification: true, requires_approver_supervisor_justification: true, description: 'ausência relacionada com a actividade sindical dos trabalhadores com cargos e funções sindicais. Estas ausências devem ser justificadas pela apresentação da justificação de presença passada pelo sindicato;'},
    {name: 'Outros Motivos', kind: :delay, code: 0, requires_document: true, requires_justification: true, requires_supervisor_justification: true, requires_supervisor_supervisor_justification: true, requires_approver_justification: true, requires_approver_supervisor_justification: true, description: 'ausências relacionadas com motivos não tipificados nas anteriores. Para o efeito, devem indicar qual o motivo da ausência no espaço reservado para o efeito. Sempre que possível, estas ausências devem ser justificadas com apresentação de documento comprovativo.'},
    # Exits
    {name: 'Doença do Trabalhador', kind: :exit, code: 0, requires_document: true, requires_justification: true, requires_supervisor_justification: true, requires_supervisor_supervisor_justification: true, requires_approver_justification: true, requires_approver_supervisor_justification: true, description: 'estão incluídas todas as Ausências por Doença súbita do Trabalhador com exceção das ausências relacionadas com Junta Médica (Baixa por Doença). Estas ausências devem ser justificadas através de atestado médico ou justificação passada pelo centro médico ou unidade hospitalar;'},
    {name: 'Consulta Médica do Trabalhador', kind: :exit, code: 0, requires_document: true, requires_justification: true, requires_supervisor_justification: true, requires_supervisor_supervisor_justification: true, requires_approver_justification: true, requires_approver_supervisor_justification: true, description: 'ausências relacionadas com consultas e exames de rotina do trabalhador. Estas ausências devem ser justificadas através de atestado médico ou justificação de presença passada pelo centro médico ou unidade hospitalar;'},
    {name: 'Assistência de familiar', kind: :exit, code: 0, requires_document: true, requires_justification: true, requires_supervisor_justification: true, requires_supervisor_supervisor_justification: true, requires_approver_justification: true, requires_approver_supervisor_justification: true, description: 'ausências relacionadas com a necessidade da prestação de assistência inadiável e imprescindível a membros do agregado familiar ou consultas/exames de rotina de filhos em idade escolar. Estas ausências devem ser justificadas através de atestado médico ou justificação de presença passada pelo centro médico ou unidade hospitalar;'},
    {name: 'Funeral', kind: :exit, code: 0, requires_document: true, requires_justification: true, requires_supervisor_justification: true, requires_supervisor_supervisor_justification: true, requires_approver_justification: true, requires_approver_supervisor_justification: true, description: 'ausência relacionada com o óbito de familiar do trabalhador. Estas ausências devem ser justificadas através da apresentação da certidão de óbito ou justificação de presença passada pelo serviço funerário;'},
    {name: 'Baixa por acidente de trabalho e doença de trabalhador', kind: '', code: 0, requires_document: true, requires_justification: true, requires_supervisor_justification: true, requires_supervisor_supervisor_justification: true, requires_approver_justification: true, requires_approver_supervisor_justification: true, description: 'todas as ausências que sejam atribuídas por junta médica na sequência de doença ou acidente de trabalho do trabalhador. Estas ausências devem ser justificadas através da apresentação do relatório da junta médica;'},
    {name: 'Obrigações Legais:', kind: :exit, code: 0, requires_document: true, requires_justification: true, requires_supervisor_justification: true, requires_supervisor_supervisor_justification: true, requires_approver_justification: true, requires_approver_supervisor_justification: true, description: 'Ausências relacionadas com motivos legais ou militares (exemplo: presenças em tribunal, cumprimento de obrigações militares, etc.). Estas ausências devem ser justificadas através da apresentação da justificação de presença passada pela entidade;'},
    {name: 'Assuntos de Sindicato', kind: :exit, code: 0, requires_document: true, requires_justification: true, requires_supervisor_justification: true, requires_supervisor_supervisor_justification: true, requires_approver_justification: true, requires_approver_supervisor_justification: true, description: 'ausência relacionada com a actividade sindical dos trabalhadores com cargos e funções sindicais. Estas ausências devem ser justificadas pela apresentação da justificação de presença passada pelo sindicato;'},
    {name: 'Outros Motivos', kind: :exit, code: 0, requires_document: true, requires_justification: true, requires_supervisor_justification: true, requires_supervisor_supervisor_justification: true, requires_approver_justification: true, requires_approver_supervisor_justification: true, description: 'ausências relacionadas com motivos não tipificados nas anteriores. Para o efeito, devem indicar qual o motivo da ausência no espaço reservado para o efeito. Sempre que possível, estas ausências devem ser justificadas com apresentação de documento comprovativo.'},
  ]
  AbsenceType.delete_all
  AbsenceType.create(absence_types)
  end
  def down
  end
end

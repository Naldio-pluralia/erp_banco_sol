class JustifiedRecord < EmployeeAttendanceRecord
  self.abstract_class = true

  # retorna o objecto do justificativo
  def justification
    self&.employee_justification
  end

  # verifica se tem justificativo
  def has_justification?
    self&.employee_justification&.present?
  end

  # verifica se o justificativo está pendente
  def is_pending?
    has_justification? && self&.employee_justification&.status == :pending
  end

  # verifica se o justificativo não foi aprovado
  def is_not_approved?
    has_justification? && self&.employee_justification&.status == :not_approved
  end

  # verifica se o justificativo foi aprovado
  def is_approved?
    has_justification? && self&.employee_justification&.status == :approved
  end

  # letra do estado
  def letter
    if self&.is_pending?
      'e'
    elsif self&.is_not_approved?
      'b'
    elsif self&.is_approved?
      'n'
    else
      ''
    end
  end

end

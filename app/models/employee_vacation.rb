class EmployeeVacation < EmployeeAttendanceRecord
  belongs_to :employee
  has_many :vacation_days, dependent: :destroy
  has_many :employee_vacation_responses, dependent: :destroy
  has_many :object_activities, as: :object, dependent: :destroy
  validates_presence_of :employee_id, :left_at, :returned_at
  validate :validates_dates
  before_validation :bv_build_vacation_days
  after_create :ac_create_responses
  after_update :au_set_responses_to_pending
  enum status: {pending: 0, approved: 1, not_approved: 2}
  attr_accessor :left_at_and_returned_at

  def name_and_date
    "Férias - #{status} - entre #{I18n.l(left_at, format: "%d-%B-%Y")} e #{I18n.l(returned_at, format: "%d-%B-%Y")} (#{number_of_days} #{number_of_days == 1 ? "dia" : "dias"})"
  end

  def notification_vacation_message
    "O colaborador #{self.employee.number} - #{self.employee.first_and_last_name}, solicitou #{name_and_date}"
  end

  def number_of_days
    vacation_days.size
  end

  def status
    if approved?
      "Aprovado"
    elsif not_approved?
      "Não approvado"
    else
      "Pendente"
    end
  end

  def letter
    if self.approved?
      'b'
    elsif self.not_approved?
      'n'
    elsif self.pending?
      'e'
    else
      ''
    end
  end

  # Its approved if all responses are approved
  def approved?
    status_map = employee_vacation_responses.map(&:status).uniq
    status_map.size == 1 && status_map.include?("approved")
  end

  # its not approved if all responses are not approved
  def not_approved?
    status_map = employee_vacation_responses.map(&:status).uniq
    status_map.size == 1 && status_map.include?("not_approved")
  end

  # when its not approved nor not approved
  def pending?
    !approved? && !not_approved?
  end

  def self.includes_responses
    includes(:employee_vacation_responses)
  end


  # Its approved if all responses are approved
  def self.approved
    where(id: select(&:approved?).map(&:id))
  end

  # its not approved if all responses are not approved
  def self.not_approved
    where(id: self.all.select(&:not_approved?).map(&:id))
  end

  # when its not approved nor not approved
  def self.pending
    where(id: self.all.select(&:pending?).map(&:id))
  end

  def self.pending_or_approved
    where(id: self.all.select{|f| f.pending? || f.approved?}.map(&:id))
  end



  def left_at_and_returned_at=(string)
    self.left_at = string.split(' ').first
    self.returned_at = string.split(' ').last
    string
  end

  def left_at_and_returned_at
    left_at.present? && returned_at.present? ? [left_at, returned_at].join(' até ') : nil
  end

  def validates_dates
    return unless returned_at.present? && left_at.present?
    if left_at >= returned_at
      errors.add(:left_at_and_returned_at, 'Deve ser anterior a data de regresso')
    else
      dates = (self.left_at...self.returned_at)
      errors.add(:left_at_and_returned_at, 'Deve ser posterior a hoje') if left_at < DateTime.now.to_date
      # errors.add(:left_at_and_returned_at, 'As datas coincidem com outro pedido') if false  && employee.employee_vacations.pending_or_approved.where.not(id: id).select{|f| (f.left_at...f.returned_at).intersects?(left_at...returned_at)}.any?
      # errors.add(:left_at_and_returned_at, 'As datas coincidem com outro registo de ausência') if false  && employee.employee_absences.select{|f| (f.left_at...f.returned_at).intersects?(left_at...returned_at) }.any?
      # errors.add(:left_at_and_returned_at, 'As datas coincidem com outro registo de Atraso') if false  && employee.employee_delays.select{|f| (left_at...returned_at).include?(f.arrived_at.to_date) }.any?
      # errors.add(:left_at_and_returned_at, 'As datas coincidem com outro registo de Saída') if false  && employee.employee_delays.select{|f| (left_at...returned_at).include?(f.date) }.any?
      if employee.has_absences_on?(dates) || employee.has_delays_on?(dates) || employee.has_exits_on?(dates) || employee.has_vacations_on?(dates, id) || employee.has_presences_on?(dates)
        errors.add(:left_at_and_returned_at, "Já tem registo nesta data")
      end
    end
  end

  def bv_build_vacation_days
    dates = (left_at...returned_at).to_a
    dates = (dates - DateType.all.map(&:date)).select{|f| not f.weekend?}.sort
    vacations = employee.employee_avaliable_vacations.with_vacations_not_overdue.order(:valid_until)
    vacation_days_aux = []
    vacations.each do |f|
      dates_aux = dates.select{|g| f.valid_until >= g}.first(f.number_of_days_remaining)
      dates_aux.each do |g|
        vacation_days_aux << {date: g, employee_avaliable_vacation_id: f.id}
      end
      dates -= dates_aux
      break if dates.empty?
    end
    if dates.size > 0
      errors.add(:left_at_and_returned_at, "Não tem dias de férias suficientes")
    else
      vacation_days.delete_all
      vacation_days.build(vacation_days_aux)
      vacation_days_aux
    end
  end

  def ac_create_responses
    supervisor = employee.efective_position&.position&.efective
    approvers = [{employee_vacation_id: id, kind: :hr}]
    if supervisor.present?
      approvers << {employee_vacation_id: id, kind: :supervisor, employee_id: supervisor.id}
      Notification.new_notification(notification_vacation_message, supervisor, "/#")
    end
    EmployeeVacationResponse.create(approvers)
  end

  def au_set_responses_to_pending
    if automatic_approve?
      employee_vacation_responses.update_all(status: :approved)
    else
      employee_vacation_responses.update_all(status: :pending)
    end
  end
end

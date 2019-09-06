class EmployeeJustification < ApplicationRecord
  belongs_to :employee_absence, optional: true
  belongs_to :employee_delay, optional: true
  belongs_to :employee_exit, optional: true
  has_one :employee, through: :employee_absence
  has_many :justification_answers, dependent: :destroy
  has_one :absence_type, through: :employee_absence
  has_many :approvers, through: :absence_type
  has_many :object_activities, as: :object, dependent: :destroy
  validates_presence_of :attachments, if: :requires_justifiaction?
  after_create :ac_create_justification_answers
  validates_presence_of :employee_absence_id, if: -> (f) {f.employee_exit_id.nil? && employee_delay_id.nil?}
  validates_presence_of :employee_delay_id, if: -> (f) {f.employee_absence_id.nil? && employee_exit_id.nil?}
  validates_presence_of :employee_exit_id, if: -> (f) {f.employee_delay_id.nil? && employee_absence_id.nil?}
  validates_uniqueness_of :employee_absence_id, if: -> (f) {f.employee_absence_id.present?}
  validates_uniqueness_of :employee_delay_id, if: -> (f) {f.employee_delay_id.present?}
  validates_uniqueness_of :employee_exit_id, if: -> (f) {f.employee_exit_id.present?}
  mount_uploaders :attachments, AttachmentsUploader
  attr_accessor :absence_object_id

  def employee_absences
    []
  end
  def employee_delays
    []
  end
  def employee_exits
    []
  end

  def absence
    employee_absence || employee_delay || employee_exit
  end

  def absence_object_id
    if employee_absence_id.present?
      "employee_absence_id_id_#{employee_absence_id}"
    elsif employee_delay_id.present?
      "employee_delay_id_id_#{employee_delay_id}"
    elsif employee_exit_id.present?
      "employee_exit_id_id_#{employee_exit_id}"
    end
  end

  def notification_justification_message
    "Foi registado um justificativo do colaborador #{self.employee.number} - #{self.employee.first_and_last_name}"
  end

  def absence_object_id=(data)
    object_id = data.split('_')&.last
    object_kind = data.split('_')
    object_kind.pop
    object_kind = object_kind.join('_')
    return unless object_id.present? && object_kind.present?
    if object_kind.eql? "employee_absence_id"
      self.employee_absence_id = object_id
      self.employee_delay_id = nil
      self.employee_exit_id = nil
    end
    if object_kind.eql? "employee_delay_id"
      self.employee_delay_id = object_id
      self.employee_exit_id = nil
      self.employee_absence_id = nil
    end
    if object_kind.eql? "employee_exit_id"
      self.employee_exit_id = object_id
      self.employee_delay_id = nil
      self.employee_absence_id = nil
    end
    data
  end

  def requires_justifiaction?
    absence&.absence_type&.requires_justification
  end

  def number
    "J#{id.to_s.rjust(8, '0')}"
  end

  # returns the required justifications
  def required_justifications
    # enum kind: {supervisor: 0, supervisor_supervisor: 1, dpe_employee: 2, dpe_supervisor: 3}
    # requires_justification
    # requires_supervisor_justification
    # requires_supervisor_supervisor_justification
    # requires_approver_justification
    # requires_approver_supervisor_justification
    m = []
    absence_type = absence&.absence_type
    return [] if absence_type.nil?
    if absence_type.requires_supervisor_justification
      m << :supervisor
    end
    if absence_type.requires_supervisor_supervisor_justification
      m << :supervisor_supervisor
    end
    if absence_type.requires_approver_justification
      m << :dpe_employee
    end
    if absence_type.requires_approver_supervisor_justification
      m << :dpe_supervisor
    end
    m
  end

  # gets the justifications already provided
  def given_justifications
    justification_answers.map{|j| j.kind.to_sym}.compact.flatten.uniq
  end

  def missing_justifications
    required_justifications - given_justifications
  end

  def justifications_avaliable_for_employee(current)
    return [] if justification_answers.map(&:employee_id).include?(current&.employee&.id)
    justifications_left = missing_justifications
    if justifications_left.includes?(:supervisor) && current.team_members.include?(employee)
      return [:supervisor]
    end
    if justifications_left.includes?(:supervisor_supervisor) && current.team_team_members.include?(employee)
      return [:supervisor_supervisor]
    end
    return approvers.map{|a| a.kind.to_sym if a.employee_id == current&.employee&.id }
  end

  def status
    if absence.automatic_approve?
      :approved
    elsif missing_justifications.size > 0
      :pending
    elsif justification_answers.map(&:status).includes?('not_approved', :not_approved)
      :not_approved
    elsif justification_answers.map(&:status).includes?('pending', :pending)
      :pending
    else
      :approved
    end
  end

  def ac_create_justification_answers
    notification_ids = []
    data = required_justifications.map do |f|
      h = {}
      h[:employee_justification_id] = id
      h[:employee_id] = employee&.efective_position&.position&.efective_id if f.eql?(:supervisor)
      h[:employee_id] = employee&.efective_position&.position&.position&.efective_id if f.eql?(:supervisor_supervisor)
      h[:status] = :pending
      h[:kind] = f
      h[:employee_justification_id] = id
      # notificar os aprovadores
      notification_ids << set_id_approver(f)
      h
    end
    p '%' * 50
    p notification_ids
    p '%' * 50
    employees = Employee.where(id: notification_ids&.flatten&.uniq)
    if employees.present? && notification_ids.present?
      employees.each do |empl|
        Notification.new_notification(message, empl, "/#")
      end
    end
    # Notification.delay.new_notification_ids(message, )
    # return if absence.automatic_approve?
    JustificationAnswer.create(data)
  end

  # mensagem que será enviada para o aprovador
  def message
    if employee_absence_id.present?
      employee_absence.notification_absence_message
    elsif employee_delay_id.present?
      employee_delay.notification_delay_message
    elsif employee_exit_id.present?
      employee_exit.notification_exit_message
    end
  end

  # faz as verficações necessárias e retorna o(s) id(s) do(s) aprovador(es)
  def set_id_approver(f)
    if f.eql?(:dpe_employee)
      self.approvers.dpe_employee.ids
    elsif f.eql?(:dpe_supervisor)
      self.approvers.dpe_supervisor.ids
    elsif f.eql?(:supervisor)
      self.employee&.efective_position&.position&.efective_id
    elsif f.eql?(:dpe_supervisor)
      self.employee&.efective_position&.position&.position&.efective_id
    end
  end

end

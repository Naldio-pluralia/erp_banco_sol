class AbsenceType < ApplicationRecord
  has_many :approvers
  accepts_nested_attributes_for :approvers
  enum kind: {absence: 0, delay: 1, exit: 2}
  validates_presence_of :kind, :name, :code#, :requires_justification#:requires_document, :requires_supervisor_justification, :requires_approver_justification, :requires_approver_supervisor_justification
  # TODO, Uma validação para garantir que se escolhe pelo menos um aprovador quando se criar um absence type
  before_create :increase_code

  # get latest absences types with out repeating the code
  def self.latests
    all_ids = all.group_by{|a| a.code}.map{|code, absences| absences.sort_by{|a| a.created_at}.last.id}.flatten.compact.uniq
    where(id: all_ids)
  end

  # increate the code after creating a new absence type
  def increase_code
    return unless code == 0 || code.nil?
    self.code = (AbsenceType.where.not(code: [0, nil]).order(code: :asc).last&.code || 0) + 1
  end

  # Busca todas ausências do sistema
  def self.system_absences
    where(is_system_absence: true)
  end

  # busca todas ausências excepto as do sistema
  def self.not_system_absences
    where(is_system_absence: false)
  end
end

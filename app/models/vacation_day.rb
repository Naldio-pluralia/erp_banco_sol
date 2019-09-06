class VacationDay < ApplicationRecord
  belongs_to :employee_vacation
  belongs_to :employee_avaliable_vacation
  validates_presence_of :date, :employee_vacation, :employee_avaliable_vacation
  validates_uniqueness_of :date, scope: [:employee_vacation_id, :employee_avaliable_vacation_id]

  # Its approved if all responses are approved
  def approved?
    employee_vacation.approved?
  end

  # its not approved if all responses are not approved
  def not_approved?
    employee_vacation.not_approved?
  end

  # when its not approved nor not approved
  def pending?
    employee_vacation.pending?
  end

  # Its approved if all responses are approved
  def self.approved
    where(id: self.select(&:approved?).map(&:id))
  end

  # its not approved if all responses are not approved
  def self.not_approved
    where(id: self.select(&:not_approved?).map(&:id))
  end

  # when its not approved nor not approved
  def self.pending
    where(id: self.select(&:pending?).map(&:id))
  end

  def self.pending_or_approved
    where(id: self.select{|f| f.approved? || f.pending?}.map(&:id))
  end

  def pending_or_approved?
    f.approved? || f.pending?
  end
end

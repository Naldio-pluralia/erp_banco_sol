class Role < ApplicationRecord
  belongs_to :account, polymorphic: true
  enum roles_mask: {unassigned: -1, admin: 0, hr_admin: 5, hr_supervisor: 10, hr_employee: 15}

  validates_presence_of :account_id, :account_type, :roles_mask
  validates :account_id, uniqueness: {scope: [:account_type]}

  # get all hr roles
  def self.hr
    where(roles_mask: [5, 10, 15])
  end

  # true if employee is from hr
  def hr?
    hr_admin? || hr_supervisor? || hr_employee?
  end
end

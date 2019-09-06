class EmployeeVacationResponse < ApplicationRecord
  belongs_to :employee_vacation
  belongs_to :employee, optional: true
  has_many :object_activities, as: :object, dependent: :destroy
  validates_presence_of :status, :kind, :employee_vacation_id
  validates_presence_of :employee_id, if: -> (f){f.supervisor? || f.id.present?}
  validates_uniqueness_of :kind, scope: [:employee_vacation_id]
  enum status: {pending: 0, approved: 1, not_approved: 2}
  enum kind: {supervisor: 0, hr: 1}

end

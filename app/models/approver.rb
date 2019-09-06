class Approver < ApplicationRecord
  belongs_to :employee, class_name: Employee.name
  belongs_to :absence_type
  enum kind: {dpe_employee: 0, dpe_supervisor: 1}
  validates_uniqueness_of :employee_id, scope: [:absence_type_id], on: :create
end

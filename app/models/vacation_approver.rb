class VacationApprover < ApplicationRecord
  belongs_to :employee
  validates_presence_of :employee_id
  validates_uniqueness_of :employee_id
end

class EmployeeSkill < ApplicationRecord
  belongs_to :skill
  belongs_to :employee

  validates_presence_of :skill_id, :employee_id
  validates_uniqueness_of :employee_id, scope: [:skill_id]
  validates_numericality_of :self_assessment, :supervisor_assessment, :value, less_than_or_equal_to: 5, greater_than_or_equal_to: 0
  # validates_numericality_of :value, less_than_or_equal_to: 10, greater_than_or_equal_to: 0
end

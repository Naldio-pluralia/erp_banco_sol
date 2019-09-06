class CorporateGoal < GoalsRecord
  belongs_to :assessment, optional: true
  belongs_to :general_goal, optional: true

  has_and_belongs_to_many :employees, association_foreign_key: :next_sgad_employee_id, foreign_key: :corporate_goal_id
  has_and_belongs_to_many :positions, association_foreign_key: :next_sgad_position_id, foreign_key: :corporate_goal_id
  has_and_belongs_to_many :functions, association_foreign_key: :next_sgad_function_id, foreign_key: :corporate_goal_id

  
end

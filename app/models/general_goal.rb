class GeneralGoal < GoalsRecord
  belongs_to :assessment, optional: true
  has_many :corporate_goals, dependent: :destroy
  has_many :team_goals, dependent: :destroy

  has_and_belongs_to_many :employees, association_foreign_key: :next_sgad_employee_id, foreign_key: :general_goal_id
  has_and_belongs_to_many :positions, association_foreign_key: :next_sgad_position_id, foreign_key: :general_goal_id
  has_and_belongs_to_many :functions, association_foreign_key: :next_sgad_function_id, foreign_key: :general_goal_id

  

  def name
    "#{self&.enum_t(:mode) || 'N/D'} - #{self&.target || 'N/D'} - #{self&.enum_t(:period) || 'N/D'}"
  end
end

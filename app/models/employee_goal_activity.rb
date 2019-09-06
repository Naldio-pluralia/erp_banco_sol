class EmployeeGoalActivity < NextSgad::EmployeeGoalActivity
  belongs_to :employee_goal
  belongs_to :creator, polymorphic: true

  validates_presence_of :employee_goal_id, :creator_id, :creator_type, :description
end
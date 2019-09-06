class Result < NextSgad::Result
  belongs_to :employee_goal
  has_one :employee, through: :employee_goal
  has_one :assessment, through: :employee_goal
  has_one :goal, through: :employee_goal

  enum status: {result_valid: 0, result_invalid: 1}

  mount_uploader :attachment, AttachmentUploader

  validates_presence_of :status, :result_value, :employee_goal_id
  validates_numericality_of :result_value, greater_than: 0
  after_create :update_employee_goal
  after_destroy :update_employee_goal


  # enum result_type: Goal.goal_types

  def increase_amount
    employee_goal = self.employee_goal
    employee_goal.amount = employee_goal.amount + self.result_value
    employee_goal.save
  end

  def change_status
    self.state = self.result_valid? ? 1 : 0
    self.save
  end

  def write_value
    result_value == result_value.to_i ? result_value.to_i : result_value
  end

  def update_employee_goal
    employee_goal.save
  end
end
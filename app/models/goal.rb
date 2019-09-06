class Goal < NextSgad::Goal
  belongs_to :assessment
  #belongs_to :goal_unit, optional: true
  has_many :employee_goals, dependent: :destroy
  has_and_belongs_to_many :positions, association_foreign_key: :next_sgad_position_id, foreign_key: :next_sgad_goal_id
  has_and_belongs_to_many :functions, association_foreign_key: :next_sgad_function_id, foreign_key: :next_sgad_goal_id

  attribute :for_a_single_employee, :boolean, default: false

  enum goal_type: {skill: 0, objective: 1}
  enum status: Assessment.statuses
  enum unit: {contracts: 0, currency: 1, clients: 2 }
  enum nature: {numeric: 0, objective_base: 1 }
  enum period: {all_year: 0,
                first_quarter: 31, second_quarter: 32, third_quarter: 33, fourth_quarter: 34,
                first_semester: 61, second_semester: 62 }

  scope :goal_type, -> (data) {data = [data].flatten.compact.uniq; data.blank? || data.include?('all') ? all : where(goal_type: data)}
  scope :assessment_id, -> (data) {data = [data].flatten.compact.uniq; data.blank? || data.include?('all') ? all : where(assessment_id: data)}

  validates_presence_of :name, :assessment_id, :status, :nature, :goal_type
  #validates_presence_of :goal_unit_id, if: :numeric?
  validates :target, numericality: {greater_than: 0, message: 'Deve ser Maior do que 0'}, if:->(goal){goal.numeric?}
  #validates :name, uniqueness: {scope: [:assessment_id]}
  after_save :create_employee_goals


  def create_employee_goals
    # checks the positions who should have this Goal
    # if the employee goal is for everyone
    positions_to = if for_everyone
      Position.where.not(efective_id: nil).can_be_assessed
    # if its a skill
    elsif skill?
      Position.where(function_id: function_ids).where.not(efective_id: nil).can_be_assessed
    # if its an objective
    elsif objective?
      positions.where.not(efective_id: nil).can_be_assessed
    end

    positions_ids = positions_to.map(&:id)
    # # Update existing employee goals
    employee_goals_to_update = employee_goals.where(position_id: positions_ids).to_a
    employee_goals_to_update.each do |employee_goal|
      employee_goal.update(status: status, goal_type: goal_type, name: name, unit: unit, nature: nature, target: target, assessment_id: assessment_id, goal_id: id)
    end

    # Destroy employee_goals deselected from the list
    employee_goals.where.not(position_id: positions_ids).each(&:destroy)
    
    # create new employee goals for the remainder
    eg = EmployeeGoal.new(status: status, goal_type: goal_type, name: name, unit: unit, nature: nature, target: target, assessment_id: assessment_id, goal_id: id)
    positions_to.where.not(id: employee_goals.map(&:position_id)).each do |position|
      dupped_eg = eg.dup
      dupped_eg.employee_id = position.efective_id
      dupped_eg.position_id = position.id
      dupped_eg.save
    end
  end
end
class Position < NextSgad::Position
  belongs_to :department, optional: true
  belongs_to :position, optional: true
  belongs_to :function, optional: true
  belongs_to :efective, optional: true, class_name: Employee.name
  belongs_to :organic_unit, optional: true, class_name: OrganicUnit.name
  belongs_to :establishment, optional: true, class_name: Establishment.name
  has_many :establishments, dependent: :destroy
  has_many :positions, dependent: :destroy
  has_many :attendances, dependent: :destroy
  # has_many :goals
  has_many :employee_goals, dependent: :destroy
  has_and_belongs_to_many :goals, association_foreign_key: :next_sgad_goal_id, foreign_key: :next_sgad_position_id
  has_and_belongs_to_many :groups, association_foreign_key: :group_id, foreign_key: :next_sgad_position_id
  has_and_belongs_to_many :employees, association_foreign_key: :next_sgad_employee_id, foreign_key: :next_sgad_position_id
  has_and_belongs_to_many :subsidy_types, association_foreign_key: :subsidy_type_id, foreign_key: :next_sgad_position_id
  has_and_belongs_to_many :tax_types, association_foreign_key: :tax_type_id, foreign_key: :next_sgad_position_id

  has_and_belongs_to_many :general_goals,   association_foreign_key: :general_goal_id,    foreign_key: :next_sgad_position_id
  has_and_belongs_to_many :corporate_goals, association_foreign_key: :corporate_goal_id,  foreign_key: :next_sgad_position_id
  has_and_belongs_to_many :team_goals,      association_foreign_key: :team_goal_id,       foreign_key: :next_sgad_position_id

  #scope :organic_unit_id, -> (data) {data = [data].flatten.compact.uniq; data.blank? || data.include?('all') ? all : where(organic_unit_id: data)}
  scope :establishment_id, -> (data) {data = [data].flatten.compact.uniq; data.blank? || data.include?('all') ? all : where(establishment_id: data)}
  scope :organic_unit_id, -> (data) {data = [data].flatten.compact.uniq; data.blank? || data.include?('all') ? all : where(id: Position.where(organic_unit_id: data)&.ids + Position.where(function_id: Function.where(organic_unit_id: data)&.ids)&.ids)}
  scope :efective_id, -> (data) {data = [data].flatten.compact.uniq; data.blank? || data.include?('all') ? all : where(efective_id: data)}
  scope :position_id, -> (data) {data = [data].flatten.compact.uniq; data.blank? || data.include?('all') ? all : where(position_id: data)}

  EMPLOYEES = {}
  after_save :as_check_efective_id

  def self.ocupied
    self.where.not(efective_id: nil)
  end

  def name_and_number
    name = ''
    name << function&.name if function&.name.present?
    name << " - #{establishment&.name}" if establishment&.name.present?
    name << " - #{organic_unit&.name}" if organic_unit&.name.present?
    "#{name || 'N/D'}"
  end

  def new_name_and_number
    name_and_number
  end

  def direction
    "#{self.function&.directorate&.name || ""} #{self.function&.name || ""} #{self.department&.name || ""}"
  end

  def new_name
    function_id.present? ? function.name_and_directorate : nil
  end

  # creates filter data
  def self.map_for_select
    all.map {|f| [f.new_name_and_number, f.id]}
  end

  # creates filter data
  def self.map_for_filter
    [[I18n.t(:everything), :all]] + all.map {|f| [f.new_name_and_number, f.id]}
  end

  INITIAL_LETTER = "P"

  #validates_uniqueness_of :efective_id, if: -> (f) {f.efective_id.present?}, on: :create
  before_save :create_number, on: :create
  #before_save :saves_employees
  #after_create :create_goals_after_create
  validates_uniqueness_of :number, if: -> (f) {f.number.present?}, on: :create

  after_create :create_goals_after_create
  # validates_presence_of :function_id, on: :update
  # validates_uniqueness_of :number, if: -> (f) {f.number.present?}, on: :create

  private
  def saves_employees
    return if self.employees_id == nil
    self.employee_ids << efective_id
    self.employee_ids = self.employee_ids.compact.uniq
  end

  # queries the positions belonging to employees tha cannot be assessed
  def self.can_be_assessed
    where(efective_id: [Employee.can_be_assessed.ids, nil])
  end

  # queries the positions belonging to employees tha can be assessed
  def self.cannot_be_assessed
    where(efective_id: Employee.cannot_be_assessed.ids)
  end

  # create employee goal after creating an position
  def create_goals_after_create
    assessm = Assessment.active.last
    return if assessm.nil? || function_id.nil? || efective_id.nil?

    employee_goal_data = assessm.goals.map{|g| {status: g.status, goal_type: g.goal_type, name: g.name, unit: g.unit, nature: g.nature, target: g.target, goal_id: g.id, employee_id: efective_id, position_id: id, assessment_id: assessm.id}}
    EmployeeGoal.create(employee_goal_data)
  end

  def self.get_by_role(current = nil)
    if current.nil?
      none
    elsif current.is?(:admin, :hr)
      all
    elsif current.is?(:manager)
      where(id: current.team_positions.ids)
    else
      none
    end
  end

  def as_check_efective_id
    Position.where.not(id: id).where(efective_id: efective_id).update_all(efective_id: nil)
  end
end

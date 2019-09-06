class Department < NextSgad::Department
  belongs_to :department, optional: true
  belongs_to :employee, optional: true
  has_many :departments
  has_many :attendances
  has_many :justifications
  has_many :positions

  INITIAL_LETTER = "D"
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_uniqueness_of :number, if: -> (f) {f.number.present?}, on: :create
  validate :parent_department
  before_save :create_number, on: :create
  scope :department_id, -> (data) {data = [data].flatten.compact.uniq; data.blank? || data.include?('all') ? all : where(employee_id: Position.where(department_id: data))}

  def parent_department
    if department_id.present? && Department.find_by(id: department_id).nil?
      errors.add(:department_id, :no_department_found_with_this_number.ts)
    end
  end

  def name_and_number
    "#{number} - #{name}"
  end

  # creates filter data
  def self.map_for_select
    all.map {|f| [f.name_and_number, f.id]}
  end

  # creates filter data
  def self.map_for_filter
    [[I18n.t(:everything), :all]] + all.map {|f| [f.name_and_number, f.id]}
  end

  # return a hash like {DepartmentObject => [EmployeeObject]}
  # groups employee by hash
  def self.employees_by_dep
    pos_ind_by_emp = Position.all.index_by(&:efective_id)
    emp_by_dep_id = all.index_by(&:id)
    Employee.all.group_by {|e| emp_by_dep_id[pos_ind_by_emp[e.id]&.department_id]}
  end

  def all_employees_of_dep
    positions = Position.where(department_id: self.id).map(&:efective_id)#all.index_by(&:efective_id)
    Employee.all.where(id: positions) #all.group_by {|e| emp_by_dep_id[pos_ind_by_emp[e.id]&.department_id]}
  end


  # return a hash like {DepartmentObject => [EmployeeAssessmentObject]}
  # groups employee by hash
  def self.employees_assessments_by_dep(employees_assessments)
    pos_ind_by_emp = Position.all.index_by(&:efective_id)
    emp_by_dep_id = all.index_by(&:id)
    employees_assessments.group_by {|e| emp_by_dep_id[pos_ind_by_emp[e.employee_id]&.department_id]}
  end


  # def self.dep_employee_goals
  #   dep_positions = Position.all.index_by(&:efective_id)
  #   dep_employees = Employee.all.index_by(&:id)
  #   dep_employee_goals = EmployeeGoal.all.group_by{|employee_goal| dep_positions[employee_goal&.employee_id]&.department_id}
  #   all.map{|dep| dep_employee_goals[dep.id]}
  # end
end

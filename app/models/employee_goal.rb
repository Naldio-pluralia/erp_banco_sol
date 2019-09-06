class EmployeeGoal < NextSgad::EmployeeGoal
  belongs_to :goal
  belongs_to :employee
  belongs_to :assessment
  belongs_to :position
  has_many :results, dependent: :destroy
  has_many :employee_goal_activities, dependent: :destroy

  enum status: Assessment.statuses
  enum goal_type: Goal.goal_types
  enum unit: Goal.units
  enum nature: Goal.natures
  
  scope :department_id, -> (data) {data = [data].flatten.compact.uniq; data.blank? || data.include?('all') ? all : where(employee_id: Position.where(department_id: data))}

  validates :goal_id, uniqueness: {scope: [:employee_id]}
  validates :self_assessment, :supervisor_assessment, :final_assessment, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 5}
  after_save :update_or_create_employee_assessment
  after_destroy :update_or_destroy_employee_assessment

  before_save :calcular_self_assessment


  def calcular_self_assessment
    return unless self.numeric?
    return if self.new_record?
    am = results.result_valid.sum(&:result_value)
    v = ((am.to_f/target.to_f)*5).round(2)
    value_amount = v >= 5 ? 5 : v
    update_columns(amount: am, self_assessment: value_amount, supervisor_assessment: value_amount, final_assessment: value_amount)
  end

  def update_amount
    return unless self.numeric?
    calcular_self_assessment
    save
  end

  def self.self_assessment_count
    return 0 if self.count <= 0
    self.where.not(self_assessment: 0).count
  end

  def self.supervisor_assessment_count
    return 0 if self.count <= 0
    self.where.not(supervisor_assessment: 0).count
  end

  def self.final_assessment_count
    return 0 if self.count <= 0
    self.where.not(final_assessment: 0).count
  end

  def self.assessment_completion_percentage_self
    employees_goals_size = self.count
    return 0 if employees_goals_size <= 0
    completed_employee_goals_size = self.where.not(self_assessment: 0).count
    100.to_f*(completed_employee_goals_size.to_f/employees_goals_size.to_f).round(2)
  end

  def self.assessment_completion_percentage_supervisor
    employees_goals_size = self.count
    return 0 if employees_goals_size <= 0
    completed_employee_goals_size = self.where.not(supervisor_assessment: 0).count
    100.to_f*(completed_employee_goals_size.to_f/employees_goals_size.to_f).round(2)
  end

  def self.assessment_completion_percentage_final
    employees_goals_size = self.count
    return 0 if employees_goals_size <= 0
    completed_employee_goals_size = self.where.not(final_assessment: 0).count
    100.to_f*(completed_employee_goals_size.to_f/employees_goals_size.to_f).round(2)
  end

  def update_or_create_employee_assessment
    employee_assessment = EmployeeAssessment.where(employee_id: employee_id, assessment_id: assessment_id).last
    if employee_assessment.present?
      employee_assessment.save
    else
      EmployeeAssessment.create(employee_id: employee_id, assessment_id: assessment_id)
    end
    assessment.employee_assessment(employee)
  end

  def self.select_where_assessment_id(assessment_ids)
    select{|e| [assessment_ids].flatten.uniq.compact.includes?(e.assessment_id) }
  end

  def self.get_by_role(current = nil)
    if current.nil?
      none
    elsif current.is?(:admin, :hr)
      all
    elsif current.is?(:manager)
      where(employee_id: current.team_members.ids)
    else
      none
    end
  end

  def employee_goals_with_notes
    EmployeeGoal.where.not(employee_note: nil)
  end

  def update_or_destroy_employee_assessment
    return if employee&.is_not_assessed?
    employee_assessment = EmployeeAssessment.where(employee_id: employee_id, assessment_id: assessment_id).last
    if employee_assessment.present?
      employee_assessment.save
    else
      EmployeeAssessment.create(employee_id: employee_id, assessment_id: assessment_id)
    end
  end
end
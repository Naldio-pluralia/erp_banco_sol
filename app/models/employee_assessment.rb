class EmployeeAssessment < NextSgad::EmployeeAssessment
  belongs_to :employee
  belongs_to :assessment
  enum self_assessment_status: {self_pending: 0, self_in_progress: 1, self_completed: 2}
  enum supervisor_assessment_status: {supervisor_pending: 0, supervisor_in_progress: 1, supervisor_completed: 2}
  enum final_assessment_status: {final_pending: 0, final_in_progress: 1, final_completed: 2}

  scope :self_assessment_status, -> (data) {data = [data].flatten.compact.uniq; data.blank? || data.include?('all') ? all :  where(self_assessment_status: data)}
  scope :supervisor_assessment_status, -> (data) {data = [data].flatten.compact.uniq; data.blank? || data.include?('all') ? all : where(supervisor_assessment_status: data)}
  scope :final_assessment_status, -> (data) {data = [data].flatten.compact.uniq; data.blank? || data.include?('all') ? all :  where(final_assessment_status: data)}

  attr_accessor :has_assessments, :all_asssessments_incomplete


  validates_uniqueness_of :employee_id, scope: :assessment_id
  after_save :update_statuses

  def employee_goals
    EmployeeGoal.where(assessment_id: assessment_id, employee_id: employee_id)
  end

  def status
    if self_completed? && supervisor_completed? && final_completed?
      :completed
    elsif self_pending? && supervisor_pending? && final_pending?
      :pending
    else
      :in_progress
    end
  end

  def pending?
    self_pending? && supervisor_pending? && final_pending?
  end

  def completed?
    self_completed? && supervisor_completed? && final_completed?
  end

  def in_progress?
    !completed? && !pending?
  end

  def not_pending?
    !pending?
  end

  def not_completed?
    !completed?
  end

  def not_in_progress?
    !in_progress?
  end

  def excelent?
    result.round == 5
  end

  def good?
    result.round == 4
  end

  def suficient?

    result.round == 3
  end

  def insuficient?
    result.round == 2
  end

  def bad?
    result.round == 1
  end

  def self.completed
    all.where(self_assessment_status: 2, supervisor_assessment_status: 2, final_assessment_status: 2)
  end

  def self.not_completed
    all.where.not(self_assessment_status: 2, supervisor_assessment_status: 2, final_assessment_status: 2)
  end

  def update_statuses
    hash = {}
    if manual
      hash[:self_assessment_status] = 2
      hash[:supervisor_assessment_status] = 2
      hash[:final_assessment_status] = 2


    else
      goals = employee_goals()

      if goals.where(self_assessment: 0).size == goals.size
        hash[:self_assessment_status] = 0
        # pending
      elsif goals.where(self_assessment: 0).exists?
        hash[:self_assessment_status] = 1
        # in_progress
      else
        hash[:self_assessment_status] = 2
        # completed
      end

      if goals.where(supervisor_assessment: 0).size == goals.size
        hash[:supervisor_assessment_status] = 0
        # pending
      elsif goals.where(supervisor_assessment: 0).exists?
        hash[:supervisor_assessment_status] = 1
        # in_progress
      else
        hash[:supervisor_assessment_status] = 2
        # completed
      end

      if goals.where(final_assessment: 0).size == goals.size
        hash[:final_assessment_status] = 0
        # pending
      elsif goals.where(final_assessment: 0).exists?
        hash[:final_assessment_status] = 1
        # in_progress
      else
        hash[:final_assessment_status] = 2
        # completed
      end
    end

    update_columns(hash)
  end

  private

end
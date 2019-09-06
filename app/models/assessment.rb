class Assessment < NextSgad::Assessment
  has_many :employee_goals, dependent: :destroy
  has_many :goals, dependent: :destroy
  has_many :attendances, dependent: :destroy
  has_many :general_goals, dependent: :destroy
  has_many :corporate_goals, dependent: :destroy
  has_many :employees_assessments, dependent: :destroy
  enum status: {draft: 0, active: 1, inactive: 2, closed: 3}

  scope :year, -> (data) {data = [data].flatten.compact.uniq; data.blank? || data.include?('all') ? all : where(year: data)}
  scope :status, -> (data) {data = [data].flatten.compact.uniq; data.blank? || data.include?('all') ? all : where(status: data)}

  validates_uniqueness_of :year
  validates_presence_of :status, :skills_percentage, :year
  validates :skills_percentage, :objectives_percentage, :attendance_percentage, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 100}
  validate :percentages_values
  validates :number_of_four_hours_delay_to_absence, :number_of_three_hours_delay_to_absence, :number_of_two_hours_delay_to_absence,
            :number_of_one_hour_delay_to_absence, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 365}

  after_create :create_employees_assessments
  after_save :update_assessments

  # get the assessment from the #{year} or the last active or from the last year
  def self.get_assessment(year = nil)
    if year.present?
      where(year: year).last
    else
      active.last || where(year: Time.now.year).last
    end
  end

  # get the last years assessment
  def get_last_assessment
    Assessment.find_by(year: year - 1)
  end

  # check if last year assessments can be copied
  def can_copy_last_years_skills?
    last_years_skills = get_last_assessment
    return false if last_years_skills.nil?
    last_years_skills.goals.skill.where.not(name: goals.skill.map(&:name)).exists?
  end

  # get last years skills
  def dup_last_year_skills
    last_years_skills = get_last_assessment
    return Goal.none if last_years_skills.nil?
    last_years_skills.goals.skill.where.not(name: goals.skill.map(&:name)).map {|g| d = g.dup; d.function_ids = g.function_ids; d}
  end

  def employee_assessment(employee)
    attendance_value = attendance_assessment(employee)
    self_assessment_value = (skills_self_assessment(employee) + objectives_self_assessment(employee) + attendance_value ).round(1)
    supervisor_assessment_value = (skills_supervisor_assessment(employee) + objectives_supervisor_assessment(employee) + attendance_value).round(1)
    assessment_value = (skills_assessment(employee) + objectives_assessment(employee) + attendance_value).round(1)
    empl_assessment = employees_assessments.where(employee_id: employee.id).where(manual: false).last
    if empl_assessment.present?
      empl_assessment.update_columns(self_result: self_assessment_value, supervisor_result: supervisor_assessment_value, result: assessment_value)
    end
    assessment_value
  end

  def skills_assessment(employee, kind = :final)
    this_employee_goals = employee_goals.skill.where(employee_id: employee.id)
    return 0 if this_employee_goals.size <= 0
    (skills_percentage/100) * (this_employee_goals.sum(&:final_assessment)/this_employee_goals.size)
  end

  def objectives_assessment(employee, kind = :final)
    this_employee_goals = employee_goals.objective.where(employee_id: employee.id)
    return 0 if this_employee_goals.size <= 0
    (objectives_percentage/100) * (this_employee_goals.sum(&:final_assessment)/this_employee_goals.size)
  end

  def skills_self_assessment(employee)
    this_employee_goals = employee_goals.skill.where(employee_id: employee.id)
    return 0 if this_employee_goals.size <= 0
    (skills_percentage/100) * (this_employee_goals.sum(&:self_assessment)/this_employee_goals.size)
  end

  def objectives_self_assessment(employee)
    this_employee_goals = employee_goals.objective.where(employee_id: employee.id)
    return 0 if this_employee_goals.size <= 0
    (objectives_percentage/100) * (this_employee_goals.sum(&:self_assessment)/this_employee_goals.size)
  end

  def skills_supervisor_assessment(employee)
    this_employee_goals = employee_goals.skill.where(employee_id: employee.id)
    return 0 if this_employee_goals.size <= 0
    (skills_percentage/100) * (this_employee_goals.sum(&:supervisor_assessment)/this_employee_goals.size)
  end

  def objectives_supervisor_assessment(employee)
    this_employee_goals = employee_goals.objective.where(employee_id: employee.id)
    return 0 if this_employee_goals.size <= 0
    (objectives_percentage/100) * (this_employee_goals.sum(&:supervisor_assessment)/this_employee_goals.size)
  end

  def attendance_assessment(employee)
    assessments_values = []
    Attendance.where(employee_id: employee.id).where("extract(year from date) = ?", year).group_by {|a| a.date.month}.each do |month, attendances_array_by_month|
      absences_number = 0
      attendances_array_by_month.group_by(&:status).each do |status, attendances_array|

        divide_by = case status
                      when 'four_hours_late'
                        number_of_four_hours_delay_to_absence
                      when 'three_hours_late'
                        number_of_three_hours_delay_to_absence

                      when 'two_hours_late'
                        number_of_two_hours_delay_to_absence

                      when 'one_hour_late'
                        number_of_one_hour_delay_to_absence

                      when 'absence'
                        1
                      else
                        0
                    end
        if divide_by > 0
          absences_number = absences_number + (attendances_array.size/divide_by).floor
        end
      end
      attendance_assessment_value = 0

      [max_absences_for_five, max_absences_for_four, max_absences_for_three, max_absences_for_two, max_absences_for_one].each_with_index do |v, index|
        if absences_number <= v
          attendance_assessment_value = 5 - index
          break
        end
      end

      assessments_values << (attendance_percentage/100) * attendance_assessment_value
    end
    if assessments_values.present?
      assessments_values.sum {|e| e}/assessments_values.size
    else
      0
    end
  end

  def attendance_assessment_by_month(employee)
    data = {}
    Attendance.where(employee_id: employee.id).where("extract(year from date) = ?", year).group_by {|a| a.date.strftime('%B')}.each do |month, attendances_array_by_month|
      absences_number = 0
      attendances_array_by_month.group_by(&:status).each do |status, attendances_array|

        divide_by = case status
                      when 'four_hours_late'
                        number_of_four_hours_delay_to_absence
                      when 'three_hours_late'
                        number_of_three_hours_delay_to_absence

                      when 'two_hours_late'
                        number_of_two_hours_delay_to_absence

                      when 'one_hour_late'
                        number_of_one_hour_delay_to_absence

                      when 'absence'
                        1
                      else
                        0
                    end
        if divide_by > 0
          absences_number = absences_number + (attendances_array.size/divide_by).floor
        end
      end
      attendance_assessment_value = 0

      [max_absences_for_five, max_absences_for_four, max_absences_for_three, max_absences_for_two, max_absences_for_one].each_with_index do |v, index|
        if absences_number <= v
          attendance_assessment_value = 5 - index
          break
        end
      end

      data[month] = [attendances_array_by_month.size, attendances_array_by_month.select(&:has_justification?).size, (attendance_percentage/100) * attendance_assessment_value]
    end
    return data
  end

  def update_assessments
    Employee.all.each{|e| employee_assessment(e)}
  end

  # get the last years assessment
  def get_last_assessment
    Assessment.find_by(year: year - 1)
  end

  # check if last year assessments can be copied
  def can_copy_last_years_skills?
    last_years_skills= get_last_assessment
    return false if last_years_skills.nil?
    last_years_skills.goals.skill.where.not(name: goals.skill.map(&:name)).exists?
  end

  # get last years skills
  def dup_last_year_skills
    last_years_skills= get_last_assessment
    return Goal.none if last_years_skills.nil?
    last_years_skills.goals.skill.where.not(name: goals.skill.map(&:name)).map {|g| d = g.dup; d.function_ids = g.function_ids; d}
  end

  def self.old_assessments_export_for_year(year)
    #employees = Employee.order(:number)
    employees_assessments = EmployeeAssessment.includes(:employee, :assessment).where('next_sgad_assessments.year' => year).order('next_sgad_employees.number')
    id_avaliacao = Assessment.find_by(year: year)
    valor_de_retorno = []
    employees_assessments.each do |employee_assessment|
      number     = employee_assessment.employee.number
      name       = employee_assessment.employee.first_and_last_name.upcase
      nota       = employee_assessment&.result
      nota_final = (nota.present? && nota > 0) ? nota : ''
      descricao  = nota.descricao
      valor_de_retorno << [number, name, nota_final, descricao]
    end
    valor_de_retorno
  end

  private
  # check if the sum of all percentages is equal to 100
  def percentages_values
    return if skills_percentage.nil? || objectives_percentage.nil? || attendance_percentage.nil?
    if skills_percentage + objectives_percentage + attendance_percentage != 100
      errors.add(:skills_percentage, 'A soma dos Objectivos, Competências e Assiduidade deve ser 100%')
      errors.add(:objectives_percentage, 'A soma dos Objectivos, Competências e Assiduidade deve ser 100%')
      errors.add(:attendance_percentage, 'A soma dos Objectivos, Competências e Assiduidade deve ser 100%')
    end
  end

  # create employee assessments for all amployees tha can be assessed
  def create_employees_assessments
    begin
      emplos = Employee.can_be_assessed.map{|e| {employee_id: e.id}}
      # Creates an array like [{employee_id: 1}, {employee_id: 3}]
      EmployeeAssessment.create(emplos) do |f|
        f.assessment_id = id
      end
    rescue
      p $!.bactrace
    end
  end
end

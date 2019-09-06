class Skill < ApplicationRecord
  has_many :employee_skills, dependent: :destroy
  has_many :function_skills, dependent: :destroy
  validates_presence_of :name
  validates_uniqueness_of :name
  after_create :after_create_create_employee_skills
  enum kind: {specific: 0, generic: 1}

  def after_create_create_employee_skills
    EmployeeSkill.create(Employee.all.map{|s| {skill_id: id, employee_id: s.id}})
  end

  def self.employees_assessments(employee_ids)
    data = []

    employees = Employee.where(id: employee_ids, can_be_assessed: true)

    employees.each do |employee|
      employee_skills = employee.get_function_employee_skills.includes(:skill)
      data << [
        number:                employee.number,
        first_and_last_name:   employee.full_name_abr,
        paygrade:              employee.paygrade.to_s,
        establishment:         employee&.efective_position&.name_and_number,
        self_assessment:       employee_skills&.average(:self_assessment)&.round_up(1),
        supervisor_assessment: employee_skills&.average(:supervisor_assessment)&.round_up(1),
        final_assessment:      employee_skills&.average(:value)&.round_up(1)
      ]
    end

    data
  end

  def self.skills_can_be_assessed_employees_assessments
    EmployeeSkill.joins(employee: {efective_position: [{function: :function_skills}, :organic_unit]}).filter_employee_can_be_assessed_and_function_skill.group('organic_units.name', 'organic_units.id').pluck("organic_units.name", "organic_units.id", "COUNT(DISTINCT employee_id)","ROUND(CAST(COUNT( CASE WHEN value > 0 and self_assessment > 0 and supervisor_assessment > 0 THEN 1 ELSE null END) AS FLOAT)*CAST(100 AS FLOAT)/CAST(count(*) AS FLOAT))", "ROUND(CAST(COUNT( CASE WHEN (value > 0 or self_assessment > 0 or supervisor_assessment > 0) and not (value > 0 and self_assessment > 0 and supervisor_assessment > 0) THEN 1 ELSE null END) AS FLOAT)*CAST(100 AS FLOAT)/CAST(count(*) AS FLOAT))", "ROUND(CAST(COUNT( CASE WHEN value = 0 and self_assessment = 0 and supervisor_assessment = 0 THEN 1 ELSE null END) AS FLOAT)*CAST(100 AS FLOAT)/CAST(count(*) AS FLOAT))")
  end


  def self.employees_with_employee_assessments_progress
    Employee.left_outer_joins(:employee_skills, efective_position: [:organic_unit, :establishment, function: :function_skills]).filter_employee_can_be_assessed_and_function_skill.group(:number, :first_name, :last_name, 'organic_units.name').pluck("number", "upper(first_name || ' ' ||last_name)", "upper(organic_units.name)" ,"CASE WHEN SUM(self_assessment) = 0 THEN 1 WHEN COUNT(CASE WHEN self_assessment > 0 THEN 1 ELSE NULL END) = COUNT(*) THEN 2 ELSE 3 END", "CASE WHEN SUM(supervisor_assessment) = 0 THEN 1 WHEN COUNT(CASE WHEN supervisor_assessment > 0 THEN 1 ELSE NULL END) = COUNT(*) THEN 2 ELSE 3 END", "CASE WHEN SUM(value) = 0 THEN 1 WHEN COUNT(CASE WHEN value > 0 THEN 1 ELSE NULL END) = COUNT(*) THEN 2 ELSE 3 END")
  end

  def self.skill_assessed_in_organic_unit(organic_unit = nil)
    return [] unless organic_unit.present?
    EmployeeSkill.joins(:skill, employee: {efective_position: [{function: :function_skills}, :organic_unit]}).filter_employee_can_be_assessed_and_function_skill.where('organic_units.id' => organic_unit).group("skills.name").pluck("skills.name", "cast(round(avg(value)) as float)")
  end

  def self.organic_unit_final_classification(organic_unit = nil)
    return [] unless organic_unit.present?
    excellent_accountant      = 0
    good_accountant           = 0
    enough_counter            = 0
    insufficient_accountant   = 0
    bad_accountant            = 0
    Employee.left_outer_joins(:employee_skills, efective_position: [:organic_unit, :establishment, function: :function_skills]).filter_employee_can_be_assessed_and_function_skill.where('organic_units.id' => organic_unit).group("next_sgad_employees.number", "next_sgad_employees.first_name", "next_sgad_employees.last_name").pluck("cast(round(avg(value)) as float)").each do |value|
      if value.present?
        if value&.to_f >= 4.5 && value&.to_f <= 5
          excellent_accountant += 1
        elsif value&.to_f >= 4 && value&.to_f < 4.5
          good_accountant += 1
        elsif value&.to_f >= 3 && value&.to_f < 4
          enough_counter += 1
        elsif value&.to_f >= 2 && value&.to_f < 3
          insufficient_accountant += 1
        elsif value&.to_f >= 0 && value&.to_f < 2
          bad_accountant += 1
        end
      end
    end

    [excellent_accountant, good_accountant, enough_counter, insufficient_accountant, bad_accountant]
  end

  def self.organic_unit_degree_of_concretization(organic_unit = nil)
    return [] unless organic_unit.present?
    completed = 0
    in_progress = 0
    not_completed = 0
    EmployeeSkill.joins(employee: {efective_position: [{function: :function_skills}, :organic_unit]}).filter_employee_can_be_assessed_and_function_skill.where('organic_units.id' => organic_unit).group("next_sgad_employees.number").pluck("count(*)", "COUNT( CASE WHEN value > 0 and self_assessment > 0 and supervisor_assessment > 0 THEN 1 ELSE null END)", "COUNT( CASE WHEN (value > 0 or self_assessment > 0 or supervisor_assessment > 0) and not (value > 0 and self_assessment > 0 and supervisor_assessment > 0) THEN 1 ELSE null END)", "COUNT( CASE WHEN value = 0 and self_assessment = 0 and supervisor_assessment = 0 THEN 1 ELSE null END)").each do |option|
      if option[3] == option[1]
        not_completed += 1
      elsif option[2] > 0 && option[2] <= option[1]
        in_progress   += 1
      elsif option[1] == option[1]
        completed     += 1
      end
    end
    [completed, in_progress, not_completed]
  end

  def self.degree_of_concretization
    completed = 0
    in_progress = 0
    not_completed = 0
    EmployeeSkill.joins(employee: {efective_position: [{function: :function_skills}, :organic_unit]}).filter_employee_can_be_assessed_and_function_skill.group("next_sgad_employees.number").pluck("count(*)", "COUNT( CASE WHEN value > 0 and self_assessment > 0 and supervisor_assessment > 0 THEN 1 ELSE null END)", "COUNT( CASE WHEN (value > 0 or self_assessment > 0 or supervisor_assessment > 0) and not (value > 0 and self_assessment > 0 and supervisor_assessment > 0) THEN 1 ELSE null END)", "COUNT( CASE WHEN value = 0 and self_assessment = 0 and supervisor_assessment = 0 THEN 1 ELSE null END)").each do |option|
      if option[3] == option[1]
        not_completed += 1
      elsif option[2] > 0 && option[2] <= option[1]
        in_progress   += 1
      elsif option[1] == option[1]
        completed     += 1
      end
    end
    [completed, in_progress, not_completed]
  end

  def self.nivel_of_concretization
    EmployeeSkill.joins(employee: {efective_position: [{function: :function_skills}, :organic_unit]}).filter_employee_can_be_assessed_and_function_skill.pluck( "round(CAST(COUNT(CASE WHEN value > 0 THEN 1 ELSE null END)*100/COUNT(value) as FLOAT))",  "round(CAST(COUNT(CASE WHEN self_assessment > 0 THEN 1 ELSE null END)*100/COUNT(self_assessment) as FLOAT))",  "round(CAST(COUNT(CASE WHEN supervisor_assessment > 0 THEN 1 ELSE null END)*100/COUNT(supervisor_assessment) as FLOAT))")[0]
  end


  def self.skill_organic_unit_comparison
    Employee.left_outer_joins(:employee_skills, efective_position: [:organic_unit, :establishment, function: :function_skills]).filter_employee_can_be_assessed_and_function_skill.where.not('organic_units.name' => nil).group('organic_units.name').pluck("upper(organic_units.name)" ,"ROUND(CAST(COUNT(CASE WHEN self_assessment > 0 or supervisor_assessment > 0 or value >0 THEN 1 ELSE null END) AS FLOAT)*CAST(100 AS FLOAT)/CAST(COUNT(*) AS FLOAT))")
  end

  def self.final_classification
    excellent_accountant      = 0
    good_accountant           = 0
    enough_counter            = 0
    insufficient_accountant   = 0
    bad_accountant            = 0
    Employee.left_outer_joins(:employee_skills, efective_position: [:organic_unit, :establishment, function: :function_skills]).filter_employee_can_be_assessed_and_function_skill.group("next_sgad_employees.number").pluck("next_sgad_employees.number", "round(cast(avg(value) as float))").each do |option|
      if option[1].present?
        if option[1]&.to_f >= 4.5 && option[1]&.to_f <= 5
          excellent_accountant += 1
        elsif option[1]&.to_f >= 4 && option[1]&.to_f < 4.5
          good_accountant += 1
        elsif option[1]&.to_f >= 3 && option[1]&.to_f < 4
          enough_counter += 1
        elsif option[1]&.to_f >= 2 && option[1]&.to_f < 3
          insufficient_accountant += 1
        elsif option[1]&.to_f >= 0 && option[1]&.to_f < 2
          bad_accountant += 1
        end
      end
    end
    [excellent_accountant, good_accountant, enough_counter, insufficient_accountant, bad_accountant]
  end

  def self.average_by_fuction
    Employee.left_outer_joins(:employee_skills, efective_position: [:organic_unit, :establishment, function: :function_skills]).filter_employee_can_be_assessed_and_function_skill.group("next_sgad_functions.name").pluck("next_sgad_functions.name", "cast(avg(value) as float)")
  end

  def self.average_by_type_assessment
    Employee.left_outer_joins(:employee_skills, efective_position: [:organic_unit, :establishment, function: :function_skills]).filter_employee_can_be_assessed_and_function_skill.pluck("cast(avg(self_assessment) as float)", "cast(avg(supervisor_assessment) as float)", "cast(avg(value) as float)")[0]
  end


  def self.percentage(value, total)
    ((value.to_f / total) * 100).round
  end

  def self.total
    Employee.where(can_be_assessed: true).map{|e| e&.efective_position&.function&.function_skills&.count}.select { |a| a != nil }.sum
  end

  def self.employee_ids
    Employee.where(can_be_assessed: true).ids
  end

  def self.skill_ids_efective_position
    Employee.where(id: self.employee_ids).map { |e| e&.efective_position&.function&.function_skills&.pluck(:skill_id)}.flatten
  end

  def self.assessed_self
    EmployeeSkill.where(skill_id: self.skill_ids_efective_position, self_assessment: 1..5).count
  end

  def self.not_assessed_self
    EmployeeSkill.where(skill_id: self.skill_ids_efective_position, self_assessment: 0).count
  end

  def self.total_assessed_self
    ((self.assessed_self) + (self.not_assessed_self))
  end

  def self.assessed_supervisor
    EmployeeSkill.where(skill_id: self.skill_ids_efective_position, supervisor_assessment: 1..5).count
  end

  def self.not_assessed_supervisor
    EmployeeSkill.where(skill_id: self.skill_ids_efective_position, supervisor_assessment: 0).count
  end

  def self.total_assessed_supervisor
    ((self.assessed_supervisor) + (self.not_assessed_supervisor))
  end

  def self.assessed_final
    EmployeeSkill.where(skill_id: self.skill_ids_efective_position, value: 1..5).count
  end

  def self.not_assessed_final
    EmployeeSkill.where(skill_id: self.skill_ids_efective_position, value: 0).count
  end

  def self.total_assessed_final
    ((self.assessed_final) + (self.not_assessed_final))
  end

end

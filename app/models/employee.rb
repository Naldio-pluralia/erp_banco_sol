class Employee < NextSgad::Employee
  # belongs_to :position
  has_many :employee_goals, dependent: :destroy
  has_many :employee_messages, dependent: :destroy
  has_many :individual_goals, dependent: :destroy
  has_many :attendances, dependent: :destroy
  has_and_belongs_to_many :positions, association_foreign_key: :next_sgad_position_id, foreign_key: :next_sgad_employee_id
  has_and_belongs_to_many :groups, association_foreign_key: :group_id, foreign_key: :next_sgad_employee_id

  has_and_belongs_to_many :general_goals,   association_foreign_key: :general_goal_id,    foreign_key: :next_sgad_employee_id
  has_and_belongs_to_many :corporate_goals, association_foreign_key: :corporate_goal_id,  foreign_key: :next_sgad_employee_id
  has_and_belongs_to_many :team_goals,      association_foreign_key: :team_goal_id,       foreign_key: :next_sgad_employee_id
  has_and_belongs_to_many :tax_types,       association_foreign_key: :tax_type_id,        foreign_key: :next_sgad_employee_id
  has_and_belongs_to_many :subsidy_types,   association_foreign_key: :subsidy_type_id,    foreign_key: :next_sgad_employee_id

  has_one :efective_position, class_name: Position.name, foreign_key: :efective_id, dependent: :destroy
  has_many :employees_assessments, dependent: :destroy
  has_many :employee_work_periods, dependent: :destroy
  has_many :employee_absences, dependent: :destroy
  has_many :employee_delays, dependent: :destroy
  has_many :employee_exits, dependent: :destroy
  has_many :employee_vacations, dependent: :destroy
  has_many :employee_presences, dependent: :destroy
  has_many :absence_days, through: :employee_absences
  has_many :vacation_days, through: :employee_vacations
  has_many :employee_justifications, dependent: :destroy
  has_many :employee_regimes, dependent: :destroy
  has_many :approvers, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :object_approvers, dependent: :destroy
  has_many :departments, dependent: :destroy

  has_many :notifications_employee, dependent: :destroy
  has_many :notifications, through: :notifications_employee, class_name: NotificationEmployee.name, dependent: :destroy
  has_one :organic_units, through: :efective_position, class_name: Position.name
  has_one :establishments, through: :efective_position, source: :establishment, class_name: Position.name
  has_one :function, through: :efective_position, class_name: Position.name
  #has_many :establishments, {:through=>:efective_position, :class_name=>"Position", :source=>"establishment"}

  has_many :employee_requests, dependent: :destroy
  has_many :employee_paygrades, dependent: :destroy
  has_many :employee_salary_families, dependent: :destroy
  has_many :employee_skills, dependent: :destroy
  has_many :skills, through: :employee_skills
  has_many :function_skills, through: :skills
  has_many :employee_avaliable_vacations, dependent: :destroy
  has_many :salaries, through: :employee_salary_families
  has_one :latest_paygrade, ->{order(since: :asc)}, class_name: EmployeeSalaryFamily.name, foreign_key: :employee_id
  has_one :user
  attr_accessor :position_id

  enum status: {activo: 0, demitido: 1, licenca: 2, estagiario: 3}

  INITIAL_LETTER = "E"
  mount_uploader :avatar, AvatarUploader

  attr_accessor :redirect_url, :cancel_url, :new_position, :position_name,
                :position_description, :position_position_id,
                :position_department_id, :position_efective_id, :position_function_id,
                :new_account, :user_email

  before_validation :set_email_to_nil_if_blank
  validates :user_email, format: {with: /\A[a-z0-9._%+-]+@bancosol.ao/i}, if: ->(employee) {employee.user_email.present? && employee.new_account.eqls?('1', 'true')}
  validates_presence_of :tolerance
  after_create :create_position_after_create
  after_update :au_update_position

  scope :employee_id, -> (data) {data = [data].flatten.compact.uniq; data.blank? || data.include?('all') ? all : where(id: data)}
  scope :department_id, -> (data) {data = [data].flatten.compact.uniq; data.blank? || data.include?('all') ? all : where(id: Position.where(department_id: data).map(&:efective_id))}
  scope :organic_unit_id, -> (data) {data = [data].flatten.compact.uniq; data.blank? || data.include?('all') ? all : where(id: Position.where(organic_unit_id: data).map(&:efective_id))}
  scope :function_id, -> (data) {data = [data].flatten.compact.uniq; data.blank? || data.include?('all') ? all : where(id: Position.where(function_id: data).map(&:efective_id))}
  scope :paygrade, -> (data) {data = [data].flatten.compact.uniq; data.blank? || data.include?('all') ? all : where(paygrade: data)}
  scope :position_id, -> (data) {data = [data].flatten.compact.uniq; data.blank? || data.include?('all') ? all : where(id: Position.where(id: data).map(&:efective_id))}
  scope :level, -> (data) {data = [data].flatten.compact.uniq; data.blank? || data.include?('all') ? all : where(level: data)}

  def position_id
    @position_id.present? ? @position_id : efective_position&.id
  end

  # busca a falta de hoje se for de sistema
  def todays_system_absence
    current_date = Date.current
    employee_absences.includes(:absence_type).select{|f| (f.left_at...f.returned_at).include?(current_date) && f.absence_type.is_system_absence }.last
  end

  def full_name
    "#{first_name} #{middle_name} #{last_name}"
  end

  def first_and_last_name
    "#{first_name} #{last_name}"
  end

  def full_abbr_name
    "#{first_name} #{middle_name.to_s.split(' ').map{|name| "#{name.first.upcase}." if name.present?}.compact.join(' ')} #{last_name}"
  end

  def full_name_abr
    #code \
    "#{first_name} #{middle_name} #{last_name}".abr_middle_name
  end

  def name_and_number
    "#{number} - #{first_name} #{last_name}"
  end

  def persona_initials
    "#{first_name.to_s.first.upcase}#{last_name.present? ? last_name.split(' ').last.to_s.first.upcase : middle_name.split(' ').last.to_s.first.upcase}"
  end

  # mensagem que sera enviada como notifcação
  def notification_create_message
    "Foi criado um novo coladordor identificado por #{number} - #{first_and_last_name}"
  end

  def notification_update_message
    "Foram actualizadas as informações do coladordor #{number} - #{first_and_last_name}"
  end

  # número de férias disponíveis
  def vacation_amount

  end

  alias_method :name, :name_and_number

  def self.map_for_select
    all.map {|f| [f.name_and_number.upcase, f.id]}
  end

  def self.map_for_filter
    [[I18n.t(:everything), :all]] + all.map {|f| [f.name_and_number, f.id]}
  end

  def self.map_paygrade_for_filter
    [[I18n.t(:everything), :all]] + all.order(paygrade: :asc).map {|f| [f.paygrade, f.paygrade]}.uniq
  end

  def self.map_level_for_filter
    [[I18n.t(:everything), :all]] + all.order(level: :asc).map {|f| [f.level, f.level]}.uniq
  end

  def unread_messages
    employee_messages.unread
  end

  def self.can_be_assessed
    where(can_be_assessed: true)
  end

  def self.cannot_be_assessed
    where(can_be_assessed: false)
  end

  def is_assessed?
    can_be_assessed
  end

  def is_not_assessed?
    !is_assessed?
  end

  # creates a new employee_paygrade
  def new_paygrade(options = {})
    options.merge!({employee_id: id})
    EmployeeSalaryFamily.new(options)
  end

  # creates a new employee_work_period
  def new_work_period(options = {})
    options.merge!({employee_id: id})
    EmployeeWorkPeriod.new(options)
  end

  # Creates a new goal just for this employee
  def new_goal(options = {})
    Goal.new(options)
  end

  def has_this_assessment?(assessment_ids)
    employees_assessments.select{|e| [assessment_ids].flatten.uniq.compact.include?(e.assessment_id)}.present?
  end

  def self.get_by_role(current = nil)
    if current.nil?
      none
    elsif current.is?(:admin, :hr)
      all
    elsif current.is?(:manager)
      where(id: current.team_members.ids)
    else
      none
    end
  end

  def set_email_to_nil_if_blank
    self.user_email = nil if user_email.blank?
  end

  def create_position_after_create
    if new_position.to_s.eqls?('1', 'true', 's', 't')
      temp_position = Position.new(name: position_name, description: position_description, position_id: position_position_id, department_id: position_department_id, function_id: position_function_id, efective_id: id)
      temp_position.save
    end
    if new_account.to_s.eqls?('1', 'true', 's', 't')
      temp_user = User.new(email: user_email)
      temp_user.last_name = last_name
      temp_user.middle_name = middle_name
      temp_user.first_name = first_name
      temp_user.temporary_password = rand(2**256).to_s(36).ljust(1, 'a')[0..9]
      temp_user.password = temp_user.temporary_password
      temp_user.password_confirmation = temp_user.temporary_password
      temp_user.employee_id = id
      temp_user.save
    end
    EmployeeSkill.create(Skill.all.map{|s| {skill_id: s.id, employee_id: id}})
  end

  # Busca todas as employee_skill para a sua função
  def get_function_employee_skills
    employee_skills.where(skill_id: efective_position&.function&.function_skills&.pluck(:skill_id))
  end

  # calcular a média da avalização
  def get_calculate_average
    value = self.get_function_employee_skills.includes(:skill)&.average(:value)
    (value.to_f < 5) ? value.to_f.round(1) : value.to_i
  end

  def has_absences_on?(dates, exclude_absences = [])
    dates = [dates].flatten.uniq
    exclude_absences = [exclude_absences].flatten
    absence_days.select{|a| !exclude_absences.include?(a.employee_absence_id) && dates.include?(a.date) }.any?
  end

  def has_delays_on?(dates, exclude_delays = [])
    dates = [dates].flatten.uniq
    exclude_delays = [exclude_delays].flatten
    employee_delays.where.not(id: exclude_delays).select{|a| ([a.arrived_at.to_date] & dates).any? }.any?
  end

  def has_exits_on?(dates, exclude_exits = [])
    dates = [dates].flatten.uniq
    exclude_exits = [exclude_exits].flatten
    employee_exits.where.not(id: exclude_exits).where(date: dates).exists?
  end

  def has_vacations_on?(dates, exclude_vacations = [])
    dates = [dates].flatten.uniq
    exclude_vacations = [exclude_vacations].flatten
    vacation_days.includes(:employee_vacation).pending_or_approved.select{|a| !exclude_vacations.include?(a.employee_vacation_id) && dates.include?(a.date) }.any?
  end

  def has_presences_on?(dates, exclude_presences = [])
    dates = [dates].flatten.uniq
    exclude_vacations = [exclude_presences].flatten
    employee_presences.confirmed.where.not(id: exclude_presences).select{|a| dates.include?(a.date) }.any?
  end

  # marcar todas notificações como lidas
  def mark_all_read
    self.notifications_employee&.update(status: :read) #.map { |e| e.update(status: :read) }
  end

  before_save :create_number, on: :create
  after_save :remove_assessment_data_if_employee_not_assessed
  validates_presence_of :first_name, :last_name, :status
  after_create :create_employees_assessments
  validates_uniqueness_of :number, if: -> (employee) {employee.number.present?}

  private
  # create employee assessment for the current employee
  def create_employees_assessments
    assessmens = Assessment.active.map{|e| {assessment_id: e.id, employee_id: id}}
    # Creates an array like [{employee_id: 1}, {employee_id: 3}]
    EmployeeAssessment.create(assessmens)
  end
  # remove all assessments if the employee can_be_assessed == false
  def remove_assessment_data_if_employee_not_assessed
    # if is_not_assessed?
    #   active_assessment = Assessment.active.last
    #   if active_assessment.present?
    #     employee_goals.where(assessment_id: active_assessment.id).delete_all
    #     attendances.where("extract(year from date) = ?", active_assessment.year).delete_all
    #     employees_assessments.where(assessment_id: active_assessment.id).where(manual: false).delete_all
    #   end
    # end
  end

  def au_update_position
    if position_id != efective_position&.id
      Position.find_by(id: position_id)&.update(efective_id: id)
    end
  end
end

class User < Account
  belongs_to :employee, class_name: Employee.name, optional: true
  scope :user_name, -> (data){data.present? ? where(id: [data].flatten.compact.uniq.map{|f| f.split(',,,')}.flatten.uniq) : all}
  scope :user_email, -> (data){data.present? ? where(id: [data].flatten.compact.uniq.map{|f| f.split(',,,')}.flatten.uniq) : all}
  scope :employee_number, -> (data){data.present? ? where(id: [data].flatten.compact.uniq.map{|f| f.split(',,,')}.flatten.uniq) : all}

  # finds the user for login using employee_number or email
  def self.find_for_database_authentication warden_conditions
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(['employee_number = :employee_number OR email = :mail', {mail: login.strip.downcase, employee_number: login.strip.upcase}]).first
  end

  # get all employees with out an account but excluding the self
  def availiable_employees
    Employee.where.not(id: User.where.not(id: id).map(&:employee_id)).order('number asc')
  end

  before_validation :set_email_to_nil_if_blank, :set_employee_number_from_id
  # validates_uniqueness_of :employee_number, if: ->(user) {user.employee_number.present?}
  validates_uniqueness_of :employee_id, if: ->(user) {user.employee_id.present?}
  validates_presence_of :email, if: ->(user) {user.employee_id.blank?}
  validates_presence_of :employee_id, if: ->(user) {user.email.blank?}
  validates :email, format: {with: EMAIL_REGEX}, if: ->(user) {user.email.present?}
  # validate :employee_number_format

  # before_save :set_email_to_nil_if_blank
  after_save :update_employee
  before_update :check_and_change_or_update_permissions

  def check_and_change_or_update_permissions
    # {"unassigned"=>-1, "admin"=>0, "hr_admin"=>5, "hr_supervisor"=>10, "hr_employee"=>15}
    # aprovador_de_faltas, aprovador_de_ferias, justificativos
    new_access = []

    new_access += [:hr]                if self&.hr_admin? || self&.hr_supervisor? || self&.hr_employee?
    new_access += [:employee]          if self&.employee&.present?
    new_access += [:supervisor]        if self&.employee&.efective_position&.positions.present?
    new_access += [:supervised]        if self&.employee&.efective_position&.position&.present?
    new_access += [:request_approver]  if self&.employee&.object_approvers&.where(object_type: RequestType.name)&.present?
    new_access += [:absence_approver]  if self&.employee&.approvers&.includes(:absence_type)&.where('absence_types.kind' => :absence)&.present?
    new_access += [:delay_approver]    if self&.employee&.approvers&.includes(:absence_type)&.where('absence_types.kind' => :delay)&.present?
    new_access += [:exit_approver]     if self&.employee&.approvers&.includes(:absence_type)&.where('absence_types.kind' => :exit)&.present?

    # order ASC
    new_access = new_access.sort

    unless self.access == new_access
      self.access = new_access
    end
  end


  private
  # check if email is blank and sets it to nil before saving
  # to prevent email with "" as value
  def set_email_to_nil_if_blank
    self.email = nil if email.blank?
  end

  def set_employee_number_from_id
    self.employee_number = employee&.number
  end

  def update_employee
    return unless employee_id.present?
    # employee.update_columns(first_name: first_name, middle_name: middle_name, last_name: last_name)
  end

  def email_required?
    true unless employee_id.present?
  end

  # # Validates if the email belongs to an employee
  # def employee_number_format
  #   return if employee_number.blank?
  #   errors.add(:employee_number, :not_a_valid_employee_number.ts(employee_number: employee_number)) if Employee.where(number: employee_number).none?
  # end
end

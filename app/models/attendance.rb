class Attendance < NextSgad::Attendance
  belongs_to :position, optional: true
  belongs_to :assessment, optional: true
  belongs_to :employee
  belongs_to :department, optional: true
  has_and_belongs_to_many :justifications, association_foreign_key: :next_sgad_justification_id, foreign_key: :next_sgad_attendance_id
  enum status: {four_hours_late: -4, three_hours_late: -3, two_hours_late: -2, one_hour_late: -1,  presence: 0, absence: 1, vacation: 2, authorized_leave: 3}
  enum justification_status: {unjustified: -1, pending: 0, approved: 1, disapproved: 2, in_progress: 3}

  scope :department_id, -> (data) {data = [data].flatten.compact.uniq; data.blank? || data.include?('all') ? all : where(department_id: data)}
  scope :year, -> (data) {data = [data].flatten.compact.uniq; data.blank? || data.include?('all') ? all : where_date(:date, year: data)}
  scope :from_date, -> (data) {data = [data].flatten.compact.uniq; data.blank? || data.include?('all') ? all : where("date >= ?", data)}
  scope :to_date, -> (data) {data = [data].flatten.compact.uniq; data.blank? || data.include?('all') ? all : where("date <= ?", data)}
  #scope :from_to_date,   -> (data){nil.present? ? where(date: [data].flatten.compact.uniq.map{|f| f.split(',,,')}.flatten.uniq.split(' - ')[0]..data.split(' - ')[1])}
  scope :employee_id, -> (data) {data = [data].flatten.compact.uniq; data.blank? || data.include?('all') ? all : where(employee_id: data)}
  scope :position_id, -> (data) {data = [data].flatten.compact.uniq; data.blank? || data.include?('all') ? all : where(position_id: data)}
  scope :assessment_id, -> (data) {data = [data].flatten.compact.uniq; data.blank? || data.include?('all') ? all : where(assessment_id: data)}
  scope :justification_status, -> (data) {data = [data].flatten.compact.uniq; data.blank? || data.include?('all') ? all : where(justification_status: data)}
  
  validates :status, :date ,:employee_id, presence: true
  validate :assessment_date
  before_create :check_employee_data

  # get all attendances with state absence or late
  def self.all_absence
    where(status: [-4,-3,-2,-1,1])
  end

  # get attendances with justification
  def self.with_justification
    where(justification_status: [0,1,2])
  end

  def self.without_justification
    where(status: [-4,-3,-2,-1,1]).where(justification_status: -1)
  end

  # true if an attendace has justification
  def has_justification?
    pending? || approved? || disapproved? || in_progress?
  end

  def justification
    justifications.last
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

  private
  def assessment_date
    
    if date.blank?
      errors.add(:date, 'Escolha uma data')
    end

    if status.blank?
      errors.add(:status, 'Escolha o estado da presença')
    end

    return unless date.present?
    
    if Attendance.where.not(id: self.id).where(employee_id: self.employee_id).where("extract(day from date) = '#{self.date.day}'").where("extract(month from date) = '#{self.date.month}'").where("extract(year from date) = '#{self.date.year}'").present?
      errors.add(:date, 'Já tem foi registado para este dia')
    end

    if Assessment.find_by(year: date.year).nil?
      errors.add(:date, "Não tem Avaliação para o ano de  #{self.date.year}")
    end

    if new_record? && date.to_date > DateTime.now.to_date
      errors.add(:date, "Não pode marcar preenças adiantadas")
    end
    # TODO See translation from plugins
  end

  def check_employee_data
    return unless employee_id.present?
    self.position_id = employee.efective_position&.id
    self.department_id = position&.department&.id
  end
end
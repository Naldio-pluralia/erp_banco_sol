class Salary < ApplicationRecord
  belongs_to :employee_salary_family
  has_many :subsidy_salaries
  has_many :tax_salaries
  has_one :employee, through: :employee_salary_family
  enum status: {draft: 0, active: 1, paid: 2}
  scope :employee_number, -> (data){data.present? ? where(id: [data].flatten.compact.uniq.map{|f| f.split(',,,')}.flatten.uniq) : all}
  scope :period, -> (data){data.present? ? where_date(month: (data).to_date.month, year: (data).to_date.year) : all}
  scope :since, -> (data){data.present? ? where('period >= ?', data.to_date) : all}
  scope :until, -> (data){data.present? ?  where('period <= ?', data.to_date) : all}
  scope :year, -> (data){data.present? ? where_date(year: data) : all}
  scope :employee_id, -> (data){data.present? ? where(employee_salary_family_id: EmployeeSalaryFamily.where(employee_id: data)) : all}
  scope :status, -> (data){data.present? ? where(status: data) : all}

  validates_presence_of :period
  after_create :create_subsidy_and_taxes
  before_validation :initialize_values, on: :create
  validate :validate_period_uniqueness

  def taxes_to_add
    taxes_ids = TaxType.get_by_code.where(kind: 0).where.not(code: tax_salaries.includes(:tax_type).map{|t| t.tax_type.code} ).ids
    taxes_ids += TaxType.get_by_code.where.not(kind: 0).where.not(kind: tax_salaries.includes(:tax_type).map{|t| t.tax_type.kind} ).ids
    TaxType.where(id: taxes_ids)
  end

  def subsidies_to_add
    subsidies_ids = SubsidyType.get_by_code.where(kind: 0).where.not(code: subsidy_salaries.includes(:subsidy_type).map{|t| t.subsidy_type.code} ).ids
    subsidies_ids += SubsidyType.get_by_code.where.not(kind: 0).where.not(kind: subsidy_salaries.includes(:subsidy_type).map{|t| t.subsidy_type.kind} ).ids
    SubsidyType.where(id: subsidies_ids)
  end

  def new_subsidy(subsidy_type)
    new_subsidy = SubsidySalary.new(salary_id: id, subsidy_type_id: subsidy_type.id, base_value: subsidy_type.subsidy_value(base_value) )
    if subsidy_type.vacation? && period.month == 12
      # TODO, Ao fazer a gestão do tempo colocar aqui as opçoões para aceitar subsidio de ferias em outros meses e em parcelas
      new_subsidy.year = period.year
    elsif subsidy_type.christmas? && period.month == 12
      # TODO, Ao fazer a gestão do tempo colocar aqui as opçoões para aceitar subsidio de ferias em outros meses e em parcelas
      new_subsidy.year = period.year
    end
    new_subsidy
  end

  def new_tax(tax_type)
    TaxSalary.new(salary_id: id, tax_type_id: tax_type.id, value: tax_type.tax_value(base_value))
  end

  def subsidies_and_taxes
    subsidy_salaries + tax_salaries
  end

  def calculate_net_value
    base_value + subsidy_salaries.sum(&:value) - tax_salaries.sum(:value)
  end

  def update_net_value
    self.update(value: calculate_net_value)
  end

  def net_value
    calculate_net_value
  end

  private
  # check if the employee has a salary for this month
  def validate_period_uniqueness
    return unless period.present?
    has_a_salary_for_this_month = Salary.where(employee_salary_family_id: EmployeeSalaryFamily.where(employee_id: employee_salary_family.employee_id).ids).where.not(id: id).where_date(:period, month: period.month, year: period.year).exists?
    if has_a_salary_for_this_month
      errors.add(:period, errors_t(:period, :already_has_period_x, x: I18n.l(self.period, format: :period)))
    end
  end

  # initialize the salarie values
  def initialize_values
    e_paygrade = employee_salary_family
    return if e_paygrade.nil? #|| e_paygrade.not_valid? #TODO, Validar se se quer criar salários para empregados que tem o employeepaygrade invalido, Ex:. depois de se actualizar a tabela de salario
    self.base_value = e_paygrade.base_salary
    self.value = base_value
  end

  # create several salaries for every emloyee for the date provided on the param
  def self.create_salaries(date = DateTime.now)
    employee_paygrades = EmployeeSalaryFamily.latest
    Salary.create employee_paygrades.map{|f| {period: date.beginning_of_month, employee_salary_family_id: f.id} }
  end

  # create subsidy and taxes
  def create_subsidy_and_taxes
    this_employee = employee
    this_position = this_employee&.efective_position
    this_function = this_position&.function

    # creates custom subsidy salaries
    SubsidyType.get_by_code.active.includes([:functions, :positions, :employees]).each do |subsidy|
      next if !subsidy.for_all && !subsidy.functions.map(&:id).include?(this_function&.id) && !subsidy.positions.map(&:id).include?(this_position&.id) && !subsidy.employees.map(&:id).include?(this_employee&.id)

      new_subsidy = SubsidySalary.new(salary_id: id, subsidy_type_id: subsidy.id, base_value: subsidy.subsidy_value(base_value) )
      if subsidy.vacation?
        next unless period.month == 12
        # TODO, Ao fazer a gestão do tempo colocar aqui as opçoões para aceitar subsidio de ferias em outros meses e em parcelas
        new_subsidy.year = period.year
      elsif subsidy.christmas?
        next unless period.month == 12
        # TODO, Ao fazer a gestão do tempo colocar aqui as opçoões para aceitar subsidio de ferias em outros meses e em parcelas
        new_subsidy.year = period.year
      end
      new_subsidy.save
    end

    # creates custom subsidy salaries
    TaxType.get_by_code.active.includes([:functions, :positions, :employees]).each do |tax|
      next if !tax.for_all && !tax.functions.map(&:id).include?(this_function&.id) && !tax.positions.map(&:id).include?(this_position&.id) && !tax.employees.map(&:id).include?(this_employee&.id)
      TaxSalary.create(salary_id: id, tax_type_id: tax.id, value: tax.tax_value(base_value))
    end
  end
end

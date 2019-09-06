class SubsidyType < SubsidyModel
  has_many :subsidy_salaries
  has_and_belongs_to_many :functions, association_foreign_key: :next_sgad_function_id, foreign_key: :subsidy_type_id, class_name: Function.name
  has_and_belongs_to_many :positions, association_foreign_key: :next_sgad_position_id, foreign_key: :subsidy_type_id, class_name: Position.name
  has_and_belongs_to_many :employees, association_foreign_key: :next_sgad_employee_id, foreign_key: :subsidy_type_id, class_name: Employee.name
  enum value_mode: {percentage: 0, fixed: 1}
  enum kind: {other: 0, christmas: 1, vacation: 2}


  def name
    if other?
      read_attribute(:name)
    else
      read_attribute(:name) || enum_t(:kind)
    end
  end

  def subsidy_value(wage_value)
    return 0 if inactive?
    if other?
      if fixed?
        value
      elsif percentage?
        (value/100) * wage_value
      else
        0
      end

    elsif vacation? || christmas?
      (value/100) * wage_value
    else
      0
    end
  end

  # busca os subsidio por grupo
  # busca todos os subsidio, mas apenas os ultimos de cada codigo e tipo
  def self.get_by_code
    # get all subsidies with kind: 0 and gets the last one
    latest_ids = SubsidyType.where(kind: 0).order(created_at: :asc).group_by(&:code).map{|k,subsidy_types| subsidy_types.last.id}
    latest_ids += SubsidyType.where.not(kind: 0).order(created_at: :asc).group_by(&:kind).map{|k,subsidy_types| subsidy_types.last.id}
    SubsidyType.where(id: latest_ids)
  end

  def dup_and_update(params = {})
    return false unless valid?
    assign_attributes(params)
    dupped = dup
    dupped.function_ids = self.function_ids
    dupped.position_ids = self.position_ids
    dupped.save
  end

  before_create :enumerate
  validates_presence_of :name, :value, :value_mode, :status, :abbr_name
  validates_numericality_of :value, greater_than: 0
  validates_numericality_of :value, less_than_or_equal_to: 100, if: ->(subsidy){subsidy.percentage? || subsidy.christmas? || subsidy.vacation?}
  # validates_uniqueness_of :name, scope: [:code]


  private
  # Cria um numero sequencial para agrupar tipos de subsidios
  def enumerate
    return if code.present?
    return unless other?
    last_code = SubsidyType.where.not(code: [nil, '']).map{|s| s.code.to_i }.sort.last
    if last_code.blank? || last_code == 0
      self.code = 1
    else
      self.code = last_code + 1
    end
  end
end

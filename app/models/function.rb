class Function < NextSgad::Function
  INITIAL_LETTER = "F"
  validates_presence_of :name
  validates_uniqueness_of :name, scope: [:organic_unit_id]
  validate :validate_schedule
  before_save :create_number, on: :create
  belongs_to :function_deslocation_regime, optional: true
  belongs_to :directorate, optional: true
  belongs_to :organic_unit, optional: true, class_name: OrganicUnit.name
  has_and_belongs_to_many :goals, association_foreign_key: :next_sgad_goal_id, foreign_key: :next_sgad_function_id
  has_and_belongs_to_many :groups, association_foreign_key: :group_id, foreign_key: :next_sgad_function_id
  has_and_belongs_to_many :messages, association_foreign_key: :next_sgad_message_id, foreign_key: :next_sgad_function_id
  has_and_belongs_to_many :subsidy_types, association_foreign_key: :subsidy_type_id, foreign_key: :next_sgad_function_id
  has_and_belongs_to_many :tax_types, association_foreign_key: :tax_type_id, foreign_key: :next_sgad_function_id
  has_and_belongs_to_many :function_autonomy_levels, association_foreign_key: :function_autonomy_level_id, foreign_key: :next_sgad_function_id
  has_and_belongs_to_many :function_subsidies, association_foreign_key: :function_subsidy_id, foreign_key: :next_sgad_function_id
  has_and_belongs_to_many :function_areas, association_foreign_key: :function_area_id, foreign_key: :next_sgad_function_id

  has_and_belongs_to_many :general_goals,   association_foreign_key: :general_goal_id,    foreign_key: :next_sgad_function_id
  has_and_belongs_to_many :corporate_goals, association_foreign_key: :corporate_goal_id,  foreign_key: :next_sgad_function_id
  has_and_belongs_to_many :team_goals,      association_foreign_key: :team_goal_id,       foreign_key: :next_sgad_function_id

  has_many :positions
  has_many :function_skills, dependent: :destroy
  enum qualification_kind: {base: 0, medio: 1, licenciatura: 2, pos_graduado: 3, mestrado: 4, phd: 5}
  enum experience_kind: {in_sector: 0, in_function: 1}

  def name_and_number
    "#{name} - #{organic_unit_id.present? ? "#{organic_unit&.name}" : 'N/D' }"
  end

  def name_number_and_directorate
    name_and_number
  end

  def name_and_directorate
    name_and_number
  end

  # creates filter data
  def self.map_for_select
    all.map {|f| [f.name_number_and_directorate.to_s.upcase, f.id]}
  end

  # creates filter data
  def self.map_for_filter
    [[I18n.t(:everything), :all]] + all.map {|f| [f.name_number_and_directorate.to_s.upcase, f.id]}
  end

  def validate_schedule
    if self.enters_at.present? && self.leaves_at.present? &&  enters_at.change(day: 1, month: 1, year: 2000) >= leaves_at.change(day: 1, month: 1, year: 2000)
      errors.add(:enters_at, errors_t(:enters_at, :before_x_date, x: I18n.l(self.leaves_at, format: '%H:%M')))
    end
  end
end

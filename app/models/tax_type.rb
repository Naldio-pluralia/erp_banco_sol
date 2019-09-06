class TaxType < TaxModel
  has_many :tax_salaries
  has_many :wage_income_tax_items, -> {order(to: :asc)}, dependent: :destroy
  has_many :subsidy_types
  has_and_belongs_to_many :functions, association_foreign_key: :next_sgad_function_id, foreign_key: :tax_type_id, class_name: Function.name
  has_and_belongs_to_many :positions, association_foreign_key: :next_sgad_position_id, foreign_key: :tax_type_id, class_name: Position.name
  has_and_belongs_to_many :employees, association_foreign_key: :next_sgad_employee_id, foreign_key: :tax_type_id, class_name: Employee.name
  accepts_nested_attributes_for :wage_income_tax_items
  enum value_mode: {fixed: 0, percentage: 1}
  enum status: {active: 0, inactive: 1}
  enum kind: {other: 0, social_security: 1, wage_income: 2}

  def name
    if other?
      read_attribute(:name)
    else
      read_attribute(:name) || enum_t(:kind)
    end
  end

  # busca os subsidio por grupo
  # busca todos os subsidio, mas apenas os ultimos de cada codigo
  def self.get_by_code
    latest_ids = TaxType.where(kind: 0).order(created_at: :asc).group_by(&:code).map{|k, tax_types| tax_types.last.id }
    latest_ids += TaxType.where.not(kind: 0).order(created_at: :asc).group_by(&:kind).map{|k,tax_types| tax_types.last.id}
    TaxType.where(id: latest_ids)
  end

  def tax_value(value_to_tax)
    return 0 if inactive?
    if other?
      if fixed?
        value
      elsif percentage?
        (value/100) * value_to_tax
      else
        0
      end

    elsif wage_income?
      return 0 if value_to_tax.round <= exempt_up_to
      if value_to_tax.round >= max_wage
        max_wage_fixed_portion + ((value_to_tax - max_wage_excess_of) * (percentage_over_max_wage_excess/100))
      else
        wage_income_tax_items.each do |wage|
          if wage.from <= value_to_tax.round && wage.to >= value_to_tax.round
            return wage.fixed_portion + ((value_to_tax - wage.excess_of) * (wage.percentage_over_the_excess/100))
          end
        end
        return 0
      end
    elsif social_security?
      (value_to_tax * (percentage_from_employee/100)).round(2)
    else
      0
    end
  end

  # duplicate current object and then saves it
  def dup_and_update(params = {})
    return false unless valid?
    assign_attributes(params)
    dupped = dup
    dupped.function_ids = [self.function_ids].flatten.uniq
    dupped.position_ids = [self.position_ids].flatten.uniq
    if wage_income?
      dupped.wage_income_tax_items.build(params[:wage_income_tax_items_attributes].to_unsafe_h.map{|k,t| t})
      dupped.validate_and_save
    else
      dupped.save
    end
  end

  def self.latest
    all.order(created_at: :asc).last
  end

  validate :validates_items, if: -> (tax){tax.wage_income?}
  validates_presence_of :exempt_up_to, :max_wage, :max_wage_fixed_portion, :percentage_over_max_wage_excess, :max_wage_excess_of, if: -> (tax){tax.wage_income?}
  validates_numericality_of :max_wage_fixed_portion, :percentage_over_max_wage_excess, greater_than_or_equal_to: 0, if: -> (tax){tax.wage_income?}
  validates_numericality_of :exempt_up_to, :max_wage_fixed_portion, greater_than: 0, if: -> (tax){tax.wage_income?}
  validates_numericality_of :percentage_over_max_wage_excess, less_than_or_equal_to: 100, if: -> (tax){tax.wage_income?}

  before_create :enumerate
  validates_presence_of :name, :status, :abbr_name
  validates_presence_of :value, :value_mode, if: ->(tax){tax.other?}
  validates_numericality_of :value, greater_than: 0, unless: -> (tax){tax.wage_income?}
  validates_numericality_of :value, less_than_or_equal_to: 100, if: ->(tax){(tax.other? && tax.percentage?) || tax.social_security?}
  # validates_uniqueness_of :name, scope: [:code]

  validates_numericality_of :percentage_from_employee, greater_than_or_equal_to: 0, less_than_or_equal_to: 100, if: ->(tax){tax.social_security?}
  validates_numericality_of :percentage_from_employer, greater_than_or_equal_to: 0, less_than_or_equal_to: 100, if: ->(tax){tax.social_security?}
  validate :validates_percentages, if: -> (tax){tax.social_security?}

  private
  def validates_items
    return unless wage_income?
    if exempt_up_to.present?
      last_wage_limit = exempt_up_to.round
      self.wage_income_tax_items.each do |g|
        # validates :to
        if g.to.present?
          g.to = g.to.round
          if last_wage_limit + 2 >= g.to
            g.errors.add(:to, errors_t('wage_income_tax.to', :greater_than, count: kwanza_t(last_wage_limit + 2)))
          end
          g.from = last_wage_limit + 1
          g.excess_of = last_wage_limit
        else
          g.errors.add(:to, errors_t('wage_income_tax.to', :blank))
          break
        end

        # fixed_portion
        if g.fixed_portion.present?
          g.fixed_portion = g.fixed_portion.round
          if g.fixed_portion < 0
            g.errors.add(:fixed_portion, errors_t('wage_income_tax_item.fixed_portion', :greater_than_or_equal_to, count: kwanza_t(0)))
          end
        else
          g.errors.add(:fixed_portion, errors_t('wage_income_tax_item.fixed_portion', :blank))
        end

        # validates percentage over the excess
        if g.percentage_over_the_excess.present?
          g.percentage_over_the_excess = g.percentage_over_the_excess.round

          if g.percentage_over_the_excess < 0
            g.errors.add(:percentage_over_the_excess, errors_t('wage_income_tax_item.percentage_over_the_excess', :greater_than_or_equal_to, count: kwanza_t(0)))
          end

          if g.percentage_over_the_excess > 100
            g.errors.add(:percentage_over_the_excess, errors_t('wage_income_tax_item.percentage_over_the_excess', :less_than_or_equal_to, count: kwanza_t(100)))
          end

        else

          g.errors.add(:percentage_over_the_excess, errors_t('wage_income_tax_item.percentage_over_the_excess', :blank))
        end

        last_wage_limit = g.to.round
      end
      self.max_wage_excess_of = last_wage_limit
      self.max_wage = last_wage_limit + 1
      if self.wage_income_tax_items.map{|s| s.errors.messages if s.errors.messages.present?}.compact.present?
        errors.add(:created_at, :blank)
      end
    end
  end

  def validates_percentages
    return unless social_security?
    return unless percentage_from_employee.present? && percentage_from_employer.present?
    unless (percentage_from_employee + percentage_from_employer) == value
      errors.add(:value, errors_t(:value, :the_sum_of_employee_percentage_end_employer_percentage_must_be_x, x: percentage_t(:value)))
    end
  end

  def enumerate
    return if code.present?
    return unless other?
    last_code = TaxType.where.not(code: [nil, '']).map{|s| s.code.to_i }.sort.last
    if last_code.blank? || last_code == 0
      self.code = 1
    else
      self.code = last_code + 1
    end
  end
end

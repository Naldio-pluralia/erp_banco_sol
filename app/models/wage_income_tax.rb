class WageIncomeTax < TaxModel
  has_many :wage_income_tax_salaries
  has_many :wage_income_tax_items
  accepts_nested_attributes_for :wage_income_tax_items

  def self.latest
    all.order(created_at: :asc).last
  end

  def create_wage_income_tax(salary)
    return unless active?
    return if salary.base_value.round <= exempt_up_to
    if salary.base_value.round >= max_wage
      value = max_wage_fixed_portion + ((salary.base_value - max_wage_excess_of) * (percentage_over_max_wage_excess/100))
      WageIncomeTaxSalary.create(salary_id: salary.id, wage_income_tax_id: id, value: value.round(2))
      return
    end
    wage_income_tax_items.each do |wage|
      if wage.from <= salary.base_value.round && wage.to >= salary.base_value.round
        value = fixed_portion + ((salary.base_value - excess_of) * (percentage_over_the_excess/100))
        WageIncomeTaxSalary.create(salary_id: salary.id, wage_income_tax_id: id, value: value.round(2))
        break
      end
    end
  end

  def validate_and_save
    # from
    # to
    # fixed_portion
    # percentage_over_the_excess
    # excess_of
    if exempt_up_to.present?
      last_wage_limit = exempt_up_to.round
      wage_income_tax_items.each do |g|
        # validates :to
        if g.to.present?
          g.to = g.to.round
          if last_wage_limit + 2 >= g.to
            p g.to
            g.errors.add(:to, errors_t('wage_income_tax.to', :greater_than, count: last_wage_limit + 2))
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
            g.errors.add(:fixed_portion, errors_t('wage_income_tax_item.fixed_portion', :greater_than_or_equal_to, count: 0))
          end
        else
          g.errors.add(:fixed_portion, errors_t('wage_income_tax_item.fixed_portion', :blank))
        end

        # validates percentage over the excess
        if g.percentage_over_the_excess.present?
          g.percentage_over_the_excess = g.percentage_over_the_excess.round

          if g.percentage_over_the_excess < 0 
            g.errors.add(:percentage_over_the_excess, errors_t('wage_income_tax_item.percentage_over_the_excess', :greater_than_or_equal_to, count: 0))
          end

          if g.percentage_over_the_excess > 100 
            g.errors.add(:percentage_over_the_excess, errors_t('wage_income_tax_item.percentage_over_the_excess', :less_than, count: 100))
          end

        else

          g.errors.add(:percentage_over_the_excess, errors_t('wage_income_tax_item.percentage_over_the_excess', :blank))
        end

        last_wage_limit = g.to.round

      end
      last_wage_item = wage_income_tax_items.last
    end
    save
  end

  validates_presence_of :exempt_up_to, :max_wage, :max_wage_fixed_portion, :percentage_over_max_wage_excess, :max_wage_excess_of
  validates_numericality_of :max_wage_fixed_portion, :percentage_over_max_wage_excess, greater_than_or_equal_to: 0
  validates_numericality_of :exempt_up_to, :max_wage, :max_wage_fixed_portion, :max_wage_excess_of, greater_than: 0
  validates_numericality_of :percentage_over_max_wage_excess, less_than_or_equal_to: 100
end

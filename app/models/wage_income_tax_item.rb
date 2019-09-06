class WageIncomeTaxItem < ApplicationRecord
  belongs_to :tax_type, required: false
  validates_presence_of :from, :to, :fixed_portion, :percentage_over_the_excess, :excess_of
end

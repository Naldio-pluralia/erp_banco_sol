class WageIncomeTaxSalary < ApplicationRecord
  belongs_to :salary
  belongs_to :wage_income_tax
end

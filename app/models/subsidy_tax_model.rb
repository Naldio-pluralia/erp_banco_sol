class SubsidyTaxModel < ApplicationRecord
  self.abstract_class = true
  enum status: {active: 0, inactive: 1}

  validates_presence_of :name, :abbr_name

end

class DateRange < ApplicationRecord
  attr_accessor :inicial, :final
  
    def initialize(date_1, date_2)
      self.inicial, self.final = [date_1, date_2].compact.sort
    end
  
    def dias
      (inicial.to_date..final.to_date).count
    end
end

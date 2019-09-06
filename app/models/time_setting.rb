class TimeSetting < ApplicationRecord
  validates_presence_of :number_of_months_to_enjoy_vacation
  validates_numericality_of :number_of_months_to_enjoy_vacation, greater_than: 1

  def self.latest
    TimeSetting.all.order(:created_at).last || TimeSetting.create(number_of_months_to_enjoy_vacation: 14)
  end
end

class FunctionSetting < ApplicationRecord
  validates_presence_of :max_chairman_number
  validates_numericality_of :max_chairman_number, greater_than_or_equal_to: 1
  def self.latest
    all.order(:max_chairman_number).last || FunctionSetting.create
  end
end

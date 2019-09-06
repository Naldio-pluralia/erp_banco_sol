class DateType < ApplicationRecord
  enum kind: {holiday: 1, extended_holiday: 2, other: 100}
  validates_uniqueness_of :date
  validates_presence_of :date, :name, :kind#, :recurrent
end

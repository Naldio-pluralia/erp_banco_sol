class SalaryCategory < ApplicationRecord
  has_many :salary_families
  validates_presence_of :name
  validates_uniqueness_of :name
end

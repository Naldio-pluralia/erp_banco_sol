class Province < ApplicationRecord
  has_many :municipalities
  
  validates_presence_of :name
  validates_uniqueness_of :name
end

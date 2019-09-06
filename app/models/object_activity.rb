class ObjectActivity < ApplicationRecord
  belongs_to :object, polymorphic: true
  belongs_to :creator, polymorphic: true
  validates_presence_of :description
end

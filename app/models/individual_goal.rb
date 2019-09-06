class IndividualGoal < ApplicationRecord
  belongs_to :pertence, polymorphic: true
  belongs_to :employee
  has_many :individual_goals, as: :pertence, dependent: :destroy

end

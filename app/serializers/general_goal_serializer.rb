class GeneralGoalSerializer < ActiveModel::Serializer
  attributes :id, :period, :objectives, :consummation, :mode
  has_one :next_sgad_assessment
  has_one :function
  has_one :position
end

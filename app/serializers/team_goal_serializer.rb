class TeamGoalSerializer < ActiveModel::Serializer
  attributes :id, :period, :objectives, :target, :mode
  has_one :general_goal
  has_one :function
  has_one :position
  has_one :assessment
end

class DirectorateSerializer < ActiveModel::Serializer
  attributes :id, :name, :abbreviation
  has_one :directorate_area
end

class OrganicUnitTypeSerializer < ActiveModel::Serializer
  attributes *OrganicUnitType.column_names
end

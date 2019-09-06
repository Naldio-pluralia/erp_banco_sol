class OrganicUnitSerializer < ActiveModel::Serializer
  attributes *OrganicUnit.column_names
end

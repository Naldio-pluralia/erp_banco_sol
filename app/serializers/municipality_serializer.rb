class MunicipalitySerializer < ActiveModel::Serializer
  attributes :id, :name
  has_one :province
end

class EstablishmentSerializer < ActiveModel::Serializer
  attributes *Establishment.column_names
=begin
  has_one :establishment_type
  has_one :municipality
=end
end

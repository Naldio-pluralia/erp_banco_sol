class PelouroSerializer < ActiveModel::Serializer
  attributes :id, :name, :abbreviation, :title, :title_abbreviation
  has_one :employee
end

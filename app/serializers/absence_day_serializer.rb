class AbsenceDaySerializer < ActiveModel::Serializer
  attributes :id, :date
  has_one :employee_absence
end

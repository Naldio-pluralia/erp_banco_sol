class EmployeeAvaliableVacationSerializer < ActiveModel::Serializer
  attributes :id, :date, :number_of_days, :valid_until
  has_one :employee
end

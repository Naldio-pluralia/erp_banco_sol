class EmployeeVacationSerializer < ActiveModel::Serializer
  attributes :id, :left_at, :returned_at, :number_of_days
  has_one :employee
end

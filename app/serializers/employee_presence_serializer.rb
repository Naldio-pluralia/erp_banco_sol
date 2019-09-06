class EmployeePresenceSerializer < ActiveModel::Serializer
  attributes :id, :date, :status
  has_one :employee
end

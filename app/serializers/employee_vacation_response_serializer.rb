class EmployeeVacationResponseSerializer < ActiveModel::Serializer
  attributes :id, :status, :kind
  has_one :employee_vacation
  has_one :employee
end

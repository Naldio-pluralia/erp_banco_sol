class VacationApproverSerializer < ActiveModel::Serializer
  attributes :id
  has_one :employee
end

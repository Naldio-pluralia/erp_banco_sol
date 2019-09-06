class VacationDaySerializer < ActiveModel::Serializer
  attributes :id, :date
  has_one :employee_vacation
  has_one :employee_avaliable_vacation
end

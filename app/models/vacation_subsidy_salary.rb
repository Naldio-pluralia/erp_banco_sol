class VacationSubsidySalary < ApplicationRecord
  belongs_to :salary
  belongs_to :vacation_subsidy
end

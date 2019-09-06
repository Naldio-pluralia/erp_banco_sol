class ObjectApprover < ApplicationRecord
  belongs_to :employee
  belongs_to :object, polymorphic: true
  enum kind: {dpe_employee: 0, dpe_supervisor: 1}
end

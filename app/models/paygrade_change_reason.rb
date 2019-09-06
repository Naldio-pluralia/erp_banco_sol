class PaygradeChangeReason < ApplicationRecord
  has_many :employee_paygrades

  validates_presence_of :reason

  def name
    reason
  end
end

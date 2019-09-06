class ReportReviewer < ApplicationRecord
  belongs_to :employee
  validates_presence_of :employee_id
  validates_uniqueness_of :employee_id

  def notification_create_body
    "Foi registada uma denúncia que precisa da sua observação #{self.employee.number} - #{self.employee.first_and_last_name}"
  end

  def notification_update_body
    "Uma denúncia foi actualizada e precisa da sua observação #{self.employee.number} - #{self.employee.first_and_last_name}"
  end
end

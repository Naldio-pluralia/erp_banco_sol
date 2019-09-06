class NotificationEmployee < ApplicationRecord
  belongs_to :notification, class_name: Notification.name
  belongs_to :employee, class_name: Employee.name

  enum status: {unread: 0, read: 1}

  def update_status
    self.read!
  end
end

class Notification < ApplicationRecord
  has_many :notifications_employee, dependent: :destroy
  has_many :employees, through: :notifications_employee, class_name: NotificationEmployee.name, dependent: :destroy

  def self.new_notification(message, employee_from, url_notification = nil)
    notification = Notification.new
    notification.description = message
    notification.url = url_notification
    if notification.save && employee_from&.present?
      # TODO implementar as notificações para multiplos destinatários
      #employees_to = employee_from&.efective_position&.map { |e| [e.id] }
      employees_to = employee_from&.efective_position&.position&.efective
      begin
        NotificationEmployee.create(notification_id: notification.id, employee_id: employee_from.id, url: url_notification)
      rescue

      end

      true
    else
      false
    end
  end

  def self.new_notification_ids(message, employee_to = [], url_notification = nil)
    notification = Notification.new
    notification.description = message
    notification.url = url_notification
    if notification.save && employee_to.present?
      NotificationEmployee.create(notification_id: notification.id, employee_id: employee_to, url: url_notification)
    end
  end

end

class Report < ApplicationRecord
  belongs_to :employee

  after_create :create_notification
  after_update :update_notification

  scope :employee_id, -> (data) {data = [data].flatten.compact.uniq; data.blank? || data.include?('all') ? all : all.not_anonymous.where(employee_id: data)}
  scope :is_anonymous, -> (data) {data = [data].flatten.compact.uniq; data.blank? || data.include?('all') ? all : all.where(is_anonymous: data)}

  enum status: {opened: 0, canceled: 1}

  def self.anonymous
    where(is_anonymous: true)
  end

  def status_opened
    self.opened!
  end

  def status_canceled
    self.canceled!
  end

  def notification_report_message
    "#{self.employee.name_and_number}, a sua denúncia foi observada."
  end

  def create_notification
    reviewers = ReportReviewer.all.includes(:employee)
    reviewers.each do |reviewer|
      Notification.new_notification(reviewer.notification_create_body, reviewer.employee, "/reports/#{self.id}")
    end
  end

  def update_notification
    reviewers = ReportReviewer.all.includes(:employee)
    reviewers.each do |reviewer|
      Notification.new_notification(reviewer.notification_update_body, reviewer.employee, "/reports/#{self.id}")
    end
    Notification.new_notification(self.notification_report_message, self.employee, "/reports/#{self.id}")
  end

  def self.not_anonymous
    where(is_anonymous: false)
  end

  def reporter
    is_anonymous ? 'Anónimo' : employee.name
  end

end

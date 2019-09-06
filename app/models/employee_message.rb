class EmployeeMessage < NextSgad::EmployeeMessage
  belongs_to :message
  belongs_to :employee
  enum status: {unread: 0, read: 1, removed: 2, unread_and_retracted: 3, read_and_retracted: 4}
  # unread :not yet read by the employee
  # read :read by the employee
  # removed :read and removed by the employee
  # unread_and_retracted :message retracted before the employee could read  it
  # read_and_retracted :message retracted afterthe employee could read it

  # recall message read and unread
  validates_presence_of :employee_id, :message_id
  validates_uniqueness_of :employee_id, scope: [:message_id]
  after_create :send_message

  # marks a message as read and saves the date the message was read
  def mark_as_read(curr_employee = nil)
    return false unless curr_employee.class.name.eql?(Employee.name)
    return false if read?
    self.update(status: :read, read_at: DateTime.now)
  end

  # sends the message after its saved
  def send_message
    user = User.find_by(employee_id: employee_id)
    return if user.nil? || user.email.blank?
    #UserMailer.send_employee_message(self).deliver_now
  end
end
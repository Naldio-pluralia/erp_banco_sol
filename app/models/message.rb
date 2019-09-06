class Message < NextSgad::Message
  has_many :employee_messages
  has_and_belongs_to_many :functions, association_foreign_key: :next_sgad_function_id, foreign_key: :next_sgad_message_id
  has_and_belongs_to_many :positions, association_foreign_key: :next_sgad_position_id, foreign_key: :next_sgad_message_id
  has_and_belongs_to_many :employees, association_foreign_key: :next_sgad_employee_id, foreign_key: :next_sgad_message_id
  has_and_belongs_to_many :organic_units , association_foreign_key: :organic_unit_id, foreign_key: :next_sgad_message_id
  enum status: {draft: 0, sent: 1}


  validates_presence_of :title, :body
  validates_presence_of :functions, if: -> (f){!f.send_to_all && f.position_ids.blank? && f.employee_ids.blank? && f.department_ids.blank? && !f.draft?}
  validates_presence_of :positions, if: -> (f){!f.send_to_all && f.employee_ids.blank? && f.department_ids.blank? && f.function_ids.blank? && !f.draft?}
  validates_presence_of :organic_units, if: -> (f){!f.send_to_all && f.position_ids.blank? && f.employee_ids.blank? && f.function_ids.blank? && !f.draft?}
  validates_presence_of :employees, if: -> (f){!f.send_to_all && f.position_ids.blank? && f.department_ids.blank? && f.function_ids.blank? && !f.draft?}

  after_save :create_messages

  def create_messages
    return unless sent?
    empl_message = EmployeeMessage.new(message_id: id, title: title, body: body, signature: signature)

    if send_to_all
      all_employees_ids = Employee.ids
    else
      all_employees_ids = Position.where(function_id: functions.ids).map(&:efective_id) +
      Position.where(department_id: departments.ids).map(&:efective_id) +
      positions.map(&:efective_id) +
      employees.ids
    end
    all_employees_ids.each do |employee_id|
      duped_empl_message = empl_message.dup
      duped_empl_message.employee_id = employee_id
      duped_empl_message.save
    end
  end
end

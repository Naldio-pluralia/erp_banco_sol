module DashboardHelper
  # get the employee department
  def employee_department(employee)
    # position = employee.efective_position
    # department = Department.find(position&.department_id)
    # department.name
  end

  # get the employee position 
  def employee_position(employee)
    # position = employee.efective_position
    # position.nil? ? t('n/a') : position.name
  end

  # get the current user employee number
  def my_employee_number
    current_account.employee_number if current.is?(:employee)
  end

  # use the method below to generate number with 0 before 
  # irb(main):> sprintf '%05d', 2
  # => 00002
end

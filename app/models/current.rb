# Should contain...
# the user on the attr user
# info about resources associated with the user

class Current < Object
  attr_accessor :user, :employee, :position, :function, :department, :has_team, :supervised, :supervisor, :role, :params

  def initialize(options = {})
    # Turns every attribute from options into instace variables
    options.each do |k, v|
      kk = k
      begin
        instance_variable_set("@#{kk}", v)
      rescue
        singleton_class.class_eval do
          attr_accessor kk
        end
        instance_variable_set("@#{kk}", v)
      end
    end
    if user.class.name.eql?(User.name)
      self.employee = user.employee
      self.position = employee&.efective_position
      self.function = position&.function
      self.department = position&.department
    end
  end

  # chek if user has a team
  def has_team?
    has_team.nil? ? (position.present? && Position.where(position_id: position.id).exists?) : has_team
  end

  # get user tem members
  def team_members
    if has_team?
      self.supervised ||= Employee.where(id: team_positions.map(&:efective_id))
    else
      Employee.none
    end
  end

  # get user team teams members
  def team_team_members
    if has_team?
      Employee.where(id: team_team_positions.map(&:efective_id))
    else
      Employee.none
    end
  end

  # get user department members
  def department_members
    Department.where(id: department.id)
    Employee.where(id: Position.where.not(department_id: nil).where(department_id: department&.id).map(&:efective_id))
  end

  # get user my department members
  def my_department_members
    departments = employee&.departments&.ids || []
    Employee.where(id: Position.where.not(department_id: nil).where(department_id: departments).map(&:efective_id))
  end

  def department_lider?
    employee&.departments&.present?
  end

  # get user team position
  def team_positions
    if has_team?
      Position.where(position_id: position&.id)
    else
      Position.none
    end
  end
  # gets user team team positions
  def team_team_positions
    if has_team?
      Position.where(position_id: Position.where(position_id: position&.id).ids).where.not(position_id: nil)
    else
      Position.none
    end
  end

  # get user department positions
  def department_positions
    Position.where.not(department_id: nil).where(department_id: department&.id)
  end

  # get user supervisor
  def team_supervisor
    self.supervisor ||= position&.position&.efective
  end

  # if has an employee object
  def employee?
    employee.present?
  end

  def just_employee?
    # TODO true if user nothing but an employee
    employee? && !has_team? && role.unassigned?
  end

  # if supervises anyone
  def manager?
    employee? && has_team?
  end

  # if is a Admin Object
  def admin?
    user.class.name == Admin.name
  end

  # check using the methods above
  # current.is?(:admin, :hr) or current.is?(:admin__hr) or current.is?(:admin_or_hr) would produce the same result which is...
  # current.admin? || current.hr?
  def is?(*roles)
    roles = [roles].flatten.join(',').to_s.gsub('__', ',').gsub('_or_', ',').split(',').uniq.map(&:to_sym)
    # other_roles will not be tested on role model they will be tested on this object
    # the code bellow intersects the roles sent from the is?() params with the 3 roles
    other_roles = [:employee, :manager, :admin, :supervisor, :department_lider] & roles
    # remove other role from role
    roles = roles - other_roles
    roles.each do |r|
      if Rails.env.development?
        return true if user.present? && user.send("#{r.to_s}?")
      else
        begin
          return true if user.present? && user.send("#{r.to_s}?")
        rescue
          puts "Error undefined method #{r.to_s}? for #{role}"
          puts $!.backtrace
        end
      end
    end
    other_roles.each do |r|
      if Rails.env.development?
        return true if self.send("#{r.to_s}?")
      else
        begin
          return true if self.send("#{r.to_s}?")
        rescue
          puts "Error undefined method #{r.to_s}? for #{self}"
          puts $!.backtrace
        end
      end
    end
    return false
  end
end

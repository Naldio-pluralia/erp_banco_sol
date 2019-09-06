class Admin < Account
  # finds the user for login using employee_number or email
  def self.find_for_database_authentication warden_conditions
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(['email = :mail', {mail: login.strip.downcase}]).first
  end
end

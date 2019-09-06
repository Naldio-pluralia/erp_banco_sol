class Activity < NextSgad::Activity
  def self.notification_result_validate(current_user, result)
    Activity.create(created_by: "#{current_user.first_name} #{current_user.last_name}", description: "Validou resultado")
  end

  def self.notification_result_invalidate(current_user, result)
    Activity.create(created_by: "#{current_user.first_name} #{current_user.last_name}", description: "Invalidou resultado")
  end

  def self.notification_new_result(current_user, result)
    Activity.create(created_by: "#{current_user.first_name} #{current_user.last_name}", description: "Adicionou novo resultado")
  end

  def self.notification_destroy_result(current_user, result)
    Activity.create(created_by: "#{current_user.first_name} #{current_user.last_name}", description: "Removido resultado")
  end
end

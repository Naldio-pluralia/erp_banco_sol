class UserMailer < ApplicationMailer

  def welcome_email(user, password)
    return unless user.email.present?
    @user = user
    @password = password
    @url  = 'https://portaldocolaboradorbancosol.pluralia.net/'
    mail(to: @user.email, subject: t('welcome_x', x: @user.first_and_last_name))
  end

  def password_reset(user, new_password)
    return unless user.email.present?
    @user = user
    @new_password = new_password
    mail to: @user.email, subject: 'password_reset'.ts
  end

  def password_generate(user, new_password)
    return unless user.email.present?
    @user = user
    @new_password = new_password
    mail to: @user.email, subject: 'new_password'.ts
  end

  def send_employee_message(employee_message)
    @user = User.find_by(employee_id: employee_message.employee_id)
    return if @user.nil? || @user.email.blank?
    mail to: @user.email, subject: mail_t('employee_message_notification')
  end
end

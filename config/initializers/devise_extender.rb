Rails.application.config.to_prepare do
  Devise::Mailer.class_eval do
    helper :email_tags # includes "ApplicationHelper"
  end
end

class ApplicationMailer < ActionMailer::Base
  helper EmailTagsHelper
  helper ActionView::Helpers::TagHelper
  default from: 'nextbss@example.com'
  layout 'mailer'

  def mail_t(text)
    I18n.t("mailers.#{self.class.name.to_s.tableize.singularize}.#{text}", default: [:"mailers.defaults.#{text}"])
  end


end

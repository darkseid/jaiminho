class NotificationMailer < ActionMailer::Base
  default from: "jaiminho@estantevirtual.com.br"
  default content_type: "text/html"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification_mailer.notify.subject
  #
  def notify(data={}, template_name)
    notification_template = NotificationTemplate.find_by_name(template_name)
    template = ERB.new(notification_template.body)
    html = template.result(binding)
    mail(to: "rmanoel@estantevirtual.com.br", body: html).deliver!
  end
end

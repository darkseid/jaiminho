class Notifier < ActionMailer::Base
  default from: "jaiminho@estantevirtual.com.br"
  default content_type: "text/html"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification_mailer.notify.subject
  #
  def notify(email_to, template_name, data={})
    template = get_template_with_name(template_name)
    html = render(template, data)
    mail(to: "rmanoel@estantevirtual.com.br", body: html).deliver!
  end

  private
  def get_template_with_name(template_name)
    template = NotificationTemplate.find_by_name!(template_name).body 
  end

  def render(template, data={})
    ERB.new(template).result(binding).chomp
  end
end

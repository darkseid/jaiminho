class Notifier < ActionMailer::Base
  # TODO: externalizar esse parametro em um arquivo de configuraçao
  default from: MAILER_CONFIG["from"]
  default content_type: "text/html"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification_mailer.notify.subject
  #
  def notify(email_to, template_name, data={})
    validate_input(email_to, template_name)
    template = get_template_with_name(template_name)
    html = render(template, data)
    mail(to: "rmanoel@estantevirtual.com.br", body: html).deliver!
  end

  private
  def validate_input(email_to, template_name)
    if email_to.blank? || template_name.blank?
      raise ArgumentError, t("jaiminho.validation")
    end
  end

  def get_template_with_name(template_name)
    template = NotificationTemplate.find_by_name!(template_name).body
  end

  def render(template, data={})
    ERB.new(template).result(binding).chomp
  end
end

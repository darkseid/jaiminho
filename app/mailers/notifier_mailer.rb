class NotifierMailer < ActionMailer::Base

  default from: MAILER_CONFIG["from"]
  default content_type: "text/html"

  def notify(email_to, template_name, data={})
    validate_input(email_to, template_name)
    template = get_template_with_name(template_name)
    html = render(template.body, data)
    subject = render(template.subject, data)
    mail(to: email_to, body: html, subject: subject).deliver
  end

  private
  def validate_input(email_to, template_name)
    if email_to.blank? || template_name.blank?
      raise ArgumentError, t("jaiminho.validation")
    end
  end

  def get_template_with_name(template_name)
    template = NotificationTemplate.find_by_name!(template_name)
  end

  def render(template, data={})
    ERB.new(template).result(binding).chomp
  end
end

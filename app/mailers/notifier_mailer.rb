class NotifierMailer < ActionMailer::Base

  default from: MAILER_CONFIG["from"]
  default content_type: "text/html"

  def notify(email_report_id)
    validate_input(email_report_id)
    email_report = EmailReport.find email_report_id
    template = get_template_with_name(email_report.template_name)
    html = render(template.body, email_report.data)
    subject = render(template.subject, email_report.data)
    mail(to: email_report.email_to, body: html, subject: subject).deliver

    set_success_to_email_report(email_report)
  end

  private
  def validate_input(email_report_id)
    unless email_report_id.is_a? Integer
      raise ArgumentError, t("jaiminho.validation")
    end
  end

  def set_success_to_email_report(email_report)
    email_report.status = :success
    email_report.save
  end

  def get_template_with_name(template_name)
    NotificationTemplate.find_by_name!(template_name)
  end

  def render(template, data={})
    ERB.new(template).result(binding).chomp
  end
end

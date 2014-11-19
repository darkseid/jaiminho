class NotifierMailer < ActionMailer::Base
  default from: MAILER_CONFIG["from"]
  default content_type: "text/html"

  def notify(email_report_id)
    validate_input email_report_id

    email_report = EmailRequest.find email_report_id
    email_template = email_report.email_template

    renderer = EmailTemplateRender.new(email_template, email_report.data)

    mail(to: email_report.email_to, body: renderer.body,
         subject: renderer.subject, reply_to: email_report.reply_to,
         cc: email_report.cc, bcc: email_report.bcc).deliver
    email_report.mark_as_successful
  end

  private

  def validate_input(email_report_id)
    fail ArgumentError, t("jaiminho.validation") \
      unless email_report_id.is_a? Integer
  end
end

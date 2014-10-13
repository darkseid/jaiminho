class NotificationMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification_mailer.notify.subject
  #
  def notify
    data = {'name' => 'Rafael'}
    template = ERB.new(NotificationTemplate.first.body)
    html = template.result(binding)
    mail to: "to@example.org", body: html
  end
end

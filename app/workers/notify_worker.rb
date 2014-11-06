class NotifyWorker
  include Sidekiq::Worker

  def perform(email_report_id)
    NotifierMailer.notify(email_report_id)
  end
end

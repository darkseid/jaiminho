class NotifyWorker

  include Sidekiq::Worker

  def perform(email_to, template_name, data)
    NotifierMailer.notify email_to, template_name, data
  end

end

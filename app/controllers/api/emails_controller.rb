require 'docs/api/emails/create_doc'

module Api
  class EmailsController < Api::ApiController

    create_doc
    def create
      @email_report = create_email_report
      error 400, 'Could not save email report.' unless @email_report.save
      @job_id = send_job(@email_report.id)
    end

    private

    def create_email_report
      EmailReport.create email_report_params
    end

    def email_report_params
      params.require(:email_report).permit :email_to,
                                           :template_name,
                                           :data, :reply_to, :cc, :bcc
    end

    def send_job(email_report_id)
      NotifyWorker.perform_async email_report_id
    end

  end
end

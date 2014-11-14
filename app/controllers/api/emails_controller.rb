module Api
  class EmailsController < Api::ApiController
    def create
      @email_report = create_email_report
      error 400, "Could not save email report." unless @email_report.save
      @job_id = send_job(@email_report.id)
    end

    def retry
      @job_ids = []
      email_retry_params.each do |id|
        email_report = EmailReport.duplicate id
        @job_ids.push(send_job(email_report.id))
      end
    end

    private

    def create_email_report
      template_name = email_template_params[:template_name]
      email_template = EmailTemplate.find_by_name template_name
      email_report_params[:email_template] = email_template
      EmailReport.create email_report_params
    end

    def email_retry_params
      params.require(:ids)
    end

    def email_report_params
      permitted_params = [:email_to, :template_name, :data,
                          :reply_to, :cc, :bcc]
      params.require(:email_report).permit permitted_params
    end

    def email_template_params
      params.require(:email_template).permit :template_name
    end

    def send_job(email_report_id)
      NotifyWorker.perform_async email_report_id
    end
  end
end

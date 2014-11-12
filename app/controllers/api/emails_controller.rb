module Api
  class EmailsController < Api::ApiController
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
      permitted_params = [:email_to, :template_name, :data,
                          :reply_to, :cc, :bcc]
      params.require(:email_report).permit permitted_params
      template_name = params[:email_report][:template_name]

      email_report_params = [:email_to, :email_template, :data,
                             :reply_to, :cc, :bcc]
      email_report_values = {}
      email_report_params.each do |param|
        email_report_values[param] = params[:email_report][param]
      end

      email_template = EmailTemplate.find_by_name(template_name)
      email_report_values[:email_template] = email_template
      email_report_values
    end

    def send_job(email_report_id)
      NotifyWorker.perform_async email_report_id
    end
  end
end

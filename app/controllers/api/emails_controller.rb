module Api
  class EmailsController < Api::ApiController
    def create
      @email_request = create_email_request
      error 400, "Could not save email report." unless @email_request.save
      @job_id = send_job(@email_request.id)
    end

    private

    def create_email_request
      template_name = email_template_params[:template_name]
      email_template = EmailTemplate.find_by_name template_name
      email_request_params[:email_template] = email_template
      EmailRequest.create email_request_params
    end

    def email_request_params
      permitted_params = [:email_to, :template_name, :data,
                          :reply_to, :cc, :bcc]
      params.require(:email_request).permit permitted_params
    end

    def email_template_params
      params.require(:email_template).permit :template_name
    end

    def send_job(email_request_id)
      NotifyWorker.perform_async email_request_id
    end
  end
end

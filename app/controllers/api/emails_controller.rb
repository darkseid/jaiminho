module Api
  class EmailsController < Api::ApiController
    def create
      @email_request = build_email_request
      error 400, "Could not save email report." unless @email_request.save
      @job_id = send_job(@email_request.id)
    end

    private

    def build_email_request
      EmailRequest.new({
        email_to: email_request_params[:to],
        email_template_id: email_request_params[:template_id],
        data: email_request_params[:data],
        reply_to: email_request_params[:reply_to],
        cc: email_request_params[:cc],
        bcc: email_request_params[:bcc]
      })
    end

    def email_request_params
      permitted_params = [:to, :template_id, :data, :reply_to, :cc, :bcc]

      @email_request_params ||= params.require(:email_request).permit permitted_params
    end

    def send_job(email_request_id)
      NotifyWorker.perform_async email_request_id
    end
  end
end

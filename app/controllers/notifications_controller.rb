class NotificationsController < ApiController

  respond_to :json

  def create
    @email_report = create_email_report
    if !@email_report.save
      error 400
    end
    @job_id = send_job(@email_report.id)
  end

  private

  def create_email_report
    EmailReport.create email_report_params
  end

  def email_report_params
    params.require(:email_report).permit :email_to, :template_name, :data, :status
  end

  def send_job(email_report_id)
    NotifyWorker.perform_async(email_report_id)
  end
end

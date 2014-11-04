class NotificationsController < ApplicationController

  # before_action :email_report_params

  respond_to :json

  def create
    @email_report = create_email_report
    NotifyWorker.perform_async(
      params[:email_to],
      params[:template_name],
      params[:data])

    head :ok
  end

  private

  def create_email_report
    EmailReport.create email_report_params
  end

  def email_report_params
    params.require(:email_report).permit :email_to, :template_name, :data
  end

end

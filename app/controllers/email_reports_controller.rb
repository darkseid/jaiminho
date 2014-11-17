class EmailReportsController < ApplicationController
  def index
    @email_reports = EmailReport.get_by_status_and_email_template_id(
      status: filter_params[:status],
      email_template_id: filter_params[:email_template_id]
    )
      
    @email_reports = @email_reports.sort_by { |email_report| email_report[:created_at] }.reverse!
    @email_templates = EmailTemplate.all
  end

  def filter_params
    params.permit(:status, :email_template_id)
  end
end

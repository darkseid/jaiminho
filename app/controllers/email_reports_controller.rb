class EmailReportsController < ApplicationController
  def index
    @email_reports = EmailReport.get_by_status_and_email_template_id(
      status: filter_params[:status],
      email_template_id: filter_params[:email_template_id]
    )
      
    @email_templates = EmailTemplate.all
  end

  def filter_params
    params.permit(:status, :email_template_id)
  end
end

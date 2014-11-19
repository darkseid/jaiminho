class EmailReportsController < ApplicationController
  def index
    @email_requests = EmailRequest.get_by_status_and_email_template_id(
      status: filter_params[:status],
      email_template_id: filter_params[:email_template_id]
    )

    @email_templates = EmailTemplate.availables
  end

  def filter_params
    params.permit(:status, :email_template_id)
  end
end

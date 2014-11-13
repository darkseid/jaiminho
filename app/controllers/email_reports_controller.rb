class EmailReportsController < ApplicationController
  def index
    @email_reports = EmailReport.filter(params.slice(:status,
                                                     :email_template_id))
    @email_reports = @email_reports.sort_by { |email_report| email_report[:created_at] }.reverse!
    @email_templates = EmailTemplate.all
  end
end
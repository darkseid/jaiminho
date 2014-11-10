class EmailReportsController < ApplicationController
  def index
    @email_reports = EmailReport.order created_at: :desc
  end
end

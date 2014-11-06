class NotificationsController < ApplicationController

  respond_to :json

  def create
    NotifyWorker.perform_async params[:email_to], params[:template_name], params[:data]
    head :ok
  end
end

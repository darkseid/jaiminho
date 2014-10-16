class NotificationsController < ApplicationController

  respond_to :json

  def create
  	Notifier.notify(params[:email_to], params[:template_name])
    head :ok
  end
end

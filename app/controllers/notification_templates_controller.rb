class NotificationTemplatesController < ApplicationController
  before_action :set_notification_template, only: [:show, :edit, :update, :destroy]

  def index
    @notification_templates = NotificationTemplate.all
  end

  def show
  end

  def new
    @notification_template = NotificationTemplate.new
  end

  def edit
  end

  def create
    @notification_template = NotificationTemplate.new(notification_template_params)
    if @notification_template.save
      redirect_to @notification_template, notice: 'Notification template was successfully created.'
    else
      render :new
    end
  end

  def update
    if @notification_template.update(notification_template_params)
      redirect_to @notification_template, notice: 'Notification template was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @notification_template.destroy
    redirect_to notification_templates_url, notice: 'Notification template was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification_template
      @notification_template = NotificationTemplate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def notification_template_params
      params.require(:notification_template).permit(:name, :body, :from, :to)
    end
end

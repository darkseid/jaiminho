class NotificationTemplatesController < ApplicationController
  before_action :set_notification_template, only: [:show, :edit, :update, :destroy]

  # GET /notification_templates
  # GET /notification_templates.json
  def index
    @notification_templates = NotificationTemplate.all
  end

  # GET /notification_templates/1
  # GET /notification_templates/1.json
  def show
  end

  # GET /notification_templates/new
  def new
    @notification_template = NotificationTemplate.new
  end

  # GET /notification_templates/1/edit
  def edit
  end

  # POST /notification_templates
  # POST /notification_templates.json
  def create
    @notification_template = NotificationTemplate.new(notification_template_params)

    respond_to do |format|
      if @notification_template.save
        format.html { redirect_to @notification_template, notice: 'Notification template was successfully created.' }
        format.json { render :show, status: :created, location: @notification_template }
      else
        format.html { render :new }
        format.json { render json: @notification_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notification_templates/1
  # PATCH/PUT /notification_templates/1.json
  def update
    respond_to do |format|
      if @notification_template.update(notification_template_params)
        format.html { redirect_to @notification_template, notice: 'Notification template was successfully updated.' }
        format.json { render :show, status: :ok, location: @notification_template }
      else
        format.html { render :edit }
        format.json { render json: @notification_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notification_templates/1
  # DELETE /notification_templates/1.json
  def destroy
    @notification_template.destroy
    respond_to do |format|
      format.html { redirect_to notification_templates_url, notice: 'Notification template was successfully destroyed.' }
      format.json { head :no_content }
    end
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

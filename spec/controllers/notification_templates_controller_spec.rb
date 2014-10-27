require "rails_helper"

RSpec.describe NotificationTemplatesController, :type => :controller do

  describe "GET index" do

    it "assigns @notification_templates" do
      notification_templates = NotificationTemplate.all
      get :index
      expect(assigns :notification_templates).to eq notification_templates
    end

  end

  describe "GET new" do
    it "renders the index template" do
      get :new
      expect(assigns :notification_template).to be_a_new NotificationTemplate
    end
  end

end

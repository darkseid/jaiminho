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

  describe "GET show" do
    let(:notification_template) {
      NotificationTemplate.new id: 1, name: "template_name_test", body: "<h1>Testing</h1>", subject: "Testing"
    }

    before :each do
      allow(NotificationTemplate).to receive(:find).with(notification_template.id.to_s).and_return notification_template
      get :show, id: notification_template
    end

    it "renders the object" do
      expect(assigns(:notification_template)).to eq notification_template
    end

  end

  describe "GET edit" do

    context "when user exists" do
      let(:notification_template) {
        NotificationTemplate.new id: 1, name: "template_name_test", body: "<h1>Testing</h1>", subject: "Testing"
      }

      before :each do
        allow(NotificationTemplate).to receive(:find).with(notification_template.id.to_s).and_return notification_template
        get :edit, id: notification_template
      end

      it "renders the object" do
        expect(assigns(:notification_template)).to eq notification_template
      end
    end

    context "when user not found" do
      it "returns record not found" do
        expect {
          get :edit, id: 0
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

  end

end

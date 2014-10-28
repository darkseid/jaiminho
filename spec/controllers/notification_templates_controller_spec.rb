require "rails_helper"

RSpec.describe NotificationTemplatesController, :type => :controller do

  let(:notification_template) { build :notification_template, id: 1, body: "<h1>Testing</h1>" }

  describe "GET" do

    describe "#index" do
      it "assigns @notification_templates" do
        notification_templates = NotificationTemplate.all
        get :index
        expect(assigns :notification_templates).to eq notification_templates
      end
    end

    describe "#new" do
      it "renders the index template" do
        get :new
        expect(assigns :notification_template).to be_a_new NotificationTemplate
      end
    end

    describe "#show" do
      context "when notification template exist" do
        before :each do
          allow(NotificationTemplate).to receive(:find).with(notification_template.id.to_s).and_return notification_template
          get :show, id: notification_template
        end

        it "renders the object" do
          expect(assigns :notification_template).to eq notification_template
        end
      end
    end

    describe "#edit" do
      context "when notification template exists" do

        before :each do
          allow(NotificationTemplate).to receive(:find).with(notification_template.id.to_s).and_return notification_template
          get :edit, id: notification_template
        end

        it "renders the object" do
          expect(assigns :notification_template).to eq notification_template
        end
      end

      context "when notification template not found" do
        it "returns record not found" do
          expect { get :edit, id: 0 }.to raise_error ActiveRecord::RecordNotFound
        end
      end

    end

  end

  describe "POST" do

    describe "#create" do
      context "when notification template is saved" do
        before do
          allow(NotificationTemplate).to receive(:find).with(notification_template.id.to_s).and_return notification_template
          allow(assigns(:notification_template)).to receive(:save).and_return true
          post :create, notification_template: {body: "body", name: "name", subject: "subject"}
        end

        it "redirects to #show" do
          expect(response).to redirect_to assigns(:notification_template)
        end

        it "show notice right" do
          expect(flash[:notice]).to match /Notification template was successfully created./
        end
      end

      context "when notification template template not saved" do
        it "render new" do
          post :create, notification_template: {body: "nothing"}
          expect(response).to render_template :new
        end
      end
    end

  end

end

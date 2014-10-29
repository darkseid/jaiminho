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

      context "with notification template existing" do

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

      context "with notification template existing" do

        before :each do
          allow(NotificationTemplate).to receive(:find).with(notification_template.id.to_s).and_return notification_template
          get :edit, id: notification_template
        end

        it "renders the object" do
          expect(assigns :notification_template).to eq notification_template
        end

        it "renders the :edit template" do
          expect(response).to render_template :edit
        end

      end

      context "with notification template not found" do

        it "returns record not found" do
          expect { get :edit, id: 0 }.to raise_error ActiveRecord::RecordNotFound
        end

      end

    end

  end

  describe "POST" do

    describe "#create" do

      context "with notification template saved" do

        before do
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

      context "with notification template template not saved" do

        it "render action new" do
          post :create, notification_template: {body: "nothing"}
          expect(response).to render_template :new
        end

      end

      context "with invalid attributes" do

        before do
          allow(assigns(:notification_template)).to receive(:save).and_return true
        end

        it "does not save save the new notification template in database" do
          expect{
            post :create,
              notification_template: attributes_for(:invalid_notification_template)
          }.to_not change(NotificationTemplate, :count)
        end

      end

    end

  end

  describe "PATCH" do

    describe "#update" do

      context "valid attributes" do

        before do
          allow(NotificationTemplate).to receive(:find).with(notification_template.id.to_s).and_return notification_template
          patch :update, id: notification_template, notification_template: {body: "changed"}
        end

        it "located the requested notification template" do
          expect(assigns :notification_template).to eq notification_template
        end

        it "changes the notification template object" do
          expect(notification_template.body).to match /changed/
        end

        it "redirects to the update notification template" do
          expect(response).to redirect_to notification_template
        end

      end

      context "invalid attributes" do

        before do
          allow(NotificationTemplate).to receive(:find).with(notification_template.id.to_s).and_return notification_template
          patch :update, id: notification_template, notification_template: {body: nil}
        end

        it "re-renders the edit template" do
          expect(response).to render_template :edit
        end

      end

    end

  end

  describe "DELETE" do

    describe "#destroy" do

      before do
        allow(NotificationTemplate).to receive(:find).with(notification_template.id.to_s).and_return notification_template
        delete :destroy, id: notification_template
      end

      it "redirects to notification_templates#index" do
        expect(response).to redirect_to notification_templates_url
      end

      it "deletes the notification template" do
        expect(notification_template.new_record?).to eq true
      end

    end

  end

end

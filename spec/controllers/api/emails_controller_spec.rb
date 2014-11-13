require "rails_helper"

RSpec.describe Api::EmailsController, type: :controller do

  describe "POST create" do
    context "with valid params" do

      let(:email_report) { build :email_report }

      before do
        allow_any_instance_of(Api::EmailsController).to \
          receive(:create_email_report).and_return email_report
        post :create, email_report: email_report.attributes, format: :json
      end

      it "returns http success" do
        expect(response).to be_success
      end

      it "save email report" do
        expect(assigns(:email_report).attributes).to \
          eql email_report.attributes
      end

      it "render create template" do
        expect(response).to render_template :create
      end
    end

    context "with invalid params" do

      let(:email_report) { build(:invalid_email_report) }

      before do
        allow_any_instance_of(Api::EmailsController).to \
          receive(:create_email_report).and_return(email_report)
        post :create, email_report: email_report.attributes, format: :json
      end

      it "render template error" do
        expect(response).to render_template :error
      end

    end
  end
end

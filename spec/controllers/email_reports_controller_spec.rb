require "rails_helper"

RSpec.describe EmailReportsController, type: :controller do
  describe "GET #index" do

    context "with populated database" do
      let(:email_report_1) { build(:email_report, created_at: Time.now - 10) }
      let(:email_report_2) { build(:email_report, created_at: Time.now) }

      before do
        allow(EmailReport).to receive(:filter) \
          .and_return [email_report_1, email_report_2]
      end

      it "render :index template" do
        get :index
        expect(response).to render_template :index
      end

      it "render an array with email_reports ordered desc by created_at" do
        get :index
        expect(assigns(:email_reports)).to eq [email_report_2, email_report_1]
      end

      it "render email_report with filter by status and template_name" do
        get :index, status: "STATUS", email_template_id: "TEMPLATE"
        params = { status: "STATUS", email_template_id: "TEMPLATE" }
        expect(EmailReport).to have_received(:filter).with(params)
      end

      it "render email_report with filter by status only" do
        get :index, status: "STATUS", wrong_param: "WRONG"
        params = { status: "STATUS" }
        expect(EmailReport).to have_received(:filter).with(params)
      end

      it "render email_report with filter by template_name only" do
        get :index, email_template_id: "TEMPLATE", wrong_param: "WRONG"
        params = { email_template_id: "TEMPLATE" }
        expect(EmailReport).to have_received(:filter).with(params)
      end

      it "render email_report getting only wrong params and with no filter" do
        get :index, wrong_param1: "TEMPLATE", wrong_param2: "TEMPLATE2"
        expect(EmailReport).to have_received(:filter).with({})
      end
    end
  end
end

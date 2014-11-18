require "rails_helper"

RSpec.describe EmailReportsController, type: :controller do
  describe "GET #index" do

    let(:email_report_1) { create(:email_report, created_at: Time.now - 10) }
    let(:email_report_2) { create(:email_report, created_at: Time.now, status: EmailReport.statuses[:failed]) }

    context "with populated database" do

      before do
        allow(EmailReport).to receive(:where) \
          .and_return [email_report_1, email_report_2]
      end

      it "render :index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    context "without params status and template_name" do

      before do
        allow(EmailReport).to receive(:where) \
          .and_return [email_report_1, email_report_2]
      end

      it "render an array with email_reports ordered desc by created_at" do
        get :index
        expect(assigns :email_reports).to eq [email_report_2, email_report_1]
      end
    end

    context "with status param given" do
      before do
        @email_report = create(:email_report)
      end

      it "returns only email_reports with success status" do
        get :index, status: EmailReport.statuses[:success]
        expect(assigns(:email_reports)).to eq [@email_report]
      end

      it "does not returns any email_report with non-valid status given" do
        get :index, status: 99
        expect(assigns(:email_reports)).to eq []
      end
    end

    context "with email_template_id param given" do
      let(:email_report){ create(:email_report) }
      let(:email_template){ email_report.email_template }

      it "return only email_reports with given email_template_id" do
        get :index, email_template_id: email_template.id
        expect(assigns(:email_reports)).to eq [email_report]
      end
    end
  end

end

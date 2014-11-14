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

      it "render an array with email_reports ordered desc by created_at" do
        get :index
        expect(assigns :email_reports).to eq [email_report_2, email_report_1]
      end
    end

    context "with params to filter" do
      before do
        @email_report = create(:email_report)
      end

      it "returns email_reports with filter" do
        get :index, status: EmailReport.statuses[:success]
        expect(assigns(:email_reports)).to eq [@email_report]
      end
    end

    context "without params to filter" do
      it "does not returns any email_report" do
        get :index, status: EmailReport.statuses[:pending]
        expect(assigns(:email_reports)).to eq []
      end
    end

  end

end

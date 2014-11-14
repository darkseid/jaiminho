require "rails_helper"

RSpec.describe Api::EmailsController, type: :controller do

  describe "POST create" do
    context "with valid params" do

      let(:email_report) { build(:email_report) }

      before do
        allow_any_instance_of(Api::EmailsController).to \
          receive(:create_email_report).and_return(email_report)
        post :create, email_report: email_report.attributes, format: :json
      end

      it "returns http success" do
        expect(response).to be_success
      end

      it "save email report" do
        expect(assigns(:email_report).save).to eq(true)
      end

      it "render create template" do
        expect(response).to render_template :create
      end

    end

    context "with invalid params" do

      let(:email_report) { build(:invalid_email_report) }
      let(:email_report_unexisting_template) do
        build(:email_report, email_template: nil)
      end

      it "render template error" do
        allow_any_instance_of(Api::EmailsController).to \
          receive(:create_email_report).and_return(email_report)

        post :create, email_report: email_report.attributes, format: :json

        expect(response).to render_template :error
      end

      it "render template error with unexisting email_template_id" do
        allow_any_instance_of(Api::EmailsController).to \
          receive(:create_email_report) \
          .and_return(email_report_unexisting_template)

        post :create, email_report: email_report_unexisting_template.attributes,
                      format: :json
        expect(response).to render_template :error
      end
    end
  end

  describe "POST retry email_report" do

    let(:email_report_0) do
      build(:email_report_with_id)
    end

    let(:email_report_1) do
      build(:email_report_with_id)
    end

    let(:email_report_2) do
      build(:email_report_with_id)
    end

    context "with valid params" do

      before do
        allow_any_instance_of(Api::EmailsController).to \
          receive(:send_job).and_return("JOB_ID")
        allow(EmailReport).to receive(:duplicate).and_return(email_report_2)
        post :retry, ids: [email_report_0.id, email_report_1.id], \
                     format: :json
      end

      it "returns http success" do
        expect(response).to be_success
      end

      it "should call duplicate method from EmailReport" do
        expect(EmailReport).to have_received(:duplicate).twice
      end

      it "render retry template" do
        expect(response).to render_template :retry
      end

      it "returns @email_reports to view" do
        expect(assigns(:job_ids)).to match %w(JOB_ID JOB_ID)
      end
    end
  end
end

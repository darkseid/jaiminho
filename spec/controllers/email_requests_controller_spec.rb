require "rails_helper"

describe EmailRequestsController, type: :controller do
  describe "GET #index" do

    let(:email_request_1) { create(:email_request, created_at: Time.now - 10) }
    let(:email_request_2) { create(:email_request, created_at: Time.now, status: EmailRequest.statuses[:failed]) }

    context "with populated database" do

      before do
        allow(EmailRequest).to receive(:where) \
          .and_return [email_request_1, email_request_2]
      end

      it "render :index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    context "without params status and template_name" do

      before do
        allow(EmailRequest).to receive(:where) \
          .and_return [email_request_1, email_request_2]
      end

      it "render an array with email_requests ordered desc by created_at" do
        get :index
        expect(assigns :email_requests).to eq [email_request_2, email_request_1]
      end
    end

    context "with status param given" do
      before do
        @email_request = create(:email_request)
      end

      it "returns only email_requests with success status" do
        get :index, status: EmailRequest.statuses[:success]
        expect(assigns(:email_requests)).to eq [@email_request]
      end

      it "does not returns any email_request with non-valid status given" do
        get :index, status: 99
        expect(assigns(:email_requests)).to eq []
      end
    end

    context "with email_template_id param given" do
      let(:email_request){ create(:email_request) }
      let(:email_template){ email_request.email_template }

      it "return only email_requests with given email_template_id" do
        get :index, email_template_id: email_template.id
        expect(assigns(:email_requests)).to eq [email_request]
      end
    end
  end

end

require "rails_helper"

RSpec.describe Api::EmailsController, type: :controller do

  describe "POST create" do

    context "with params is valid" do

      let(:email_request) { build :email_request }

      before do
        params = {
          "to" => "rcuba@estantevirtual.com.br",
          "template_id" => 1,
          "data" => {"name" => "Raphael Cuba"}
        }
        allow_any_instance_of(EmailRequest).to receive(:save).and_return true
        post :create, email_request: params, format: :json
      end

      it "returns http success" do
        expect(response).to be_success
      end

      it "builds the email_request" do
        expect(assigns(:email_request).email_to).to eq "rcuba@estantevirtual.com.br"
      end

      it "render create template" do
        expect(response).to render_template :create
      end

    end

    context "with params is invalid" do

      let(:email_request) { attributes_for :invalid_email_request }

      before do
        allow_any_instance_of(EmailRequest).to receive(:save).and_return false
        post :create, email_request: email_request, format: :json
      end

      it "renders error template" do
        expect(response).to render_template :error
      end

      it "return http status code error" do
        expect(response).to have_http_status 400
      end

    end
  end

end

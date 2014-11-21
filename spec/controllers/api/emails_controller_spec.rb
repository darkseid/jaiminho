require "rails_helper"

RSpec.describe Api::EmailsController, type: :controller do

  describe "POST create" do
    context "with valid params" do

      let(:email_request) { build(:email_request) }

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

    context "with invalid params" do

      let(:email_request) { build(:invalid_email_request) }
      let(:email_request_unexisting_template) do
        build(:email_request, email_template: nil)
      end

      it "render template error" do
        allow_any_instance_of(Api::EmailsController).to \
          receive(:create_email_request).and_return(email_request)

        post :create, email_request: email_request.attributes, format: :json

        expect(response).to render_template :error
      end

      it "render template error with unexisting email_template_id" do
        allow_any_instance_of(Api::EmailsController).to \
          receive(:create_email_request) \
          .and_return(email_request_unexisting_template)

        post :create, email_request: email_request_unexisting_template.attributes,
                      format: :json
        expect(response).to render_template :error
      end
    end
  end
end

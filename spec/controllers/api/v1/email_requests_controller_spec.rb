require "rails_helper"
module Api
   module V1
    describe EmailRequestsController, type: :controller do

      describe "POST create" do
        let(:valid_token){ ApiKey.create.access_token }
        let(:token){ActionController::HttpAuthentication::Token.encode_credentials(valid_token)}

        context "with valid params and valid token" do
          let(:email_request) { build :email_request }

          before do
            request.headers['HTTP_AUTHORIZATION'] = token
            params = {
              "to" => "rcuba@estantevirtual.com.br",
              "template_id" => 1,
              "data" => {"name" => "Raphael Cuba"}
            }
            allow_any_instance_of(EmailRequest).to receive(:save).and_return true
            post :create, email_request: params, format: :json
          end

          it "builds the email_request" do
            expect(assigns(:email_request).email_to).to eq "rcuba@estantevirtual.com.br"
          end

          it "returns created status code (201)" do
            expect(response).to have_http_status(:created)
          end
        end

        context "with invalid params and valid token" do
          before do
            params = {
              "email_to" => nil,
              "template" => 1,
              "data" => {"name" => "Raphael Cuba"}
            }
            request.headers['HTTP_AUTHORIZATION'] = token
            allow_any_instance_of(EmailRequest).to receive(:save).and_return false
            post :create, email_request: params, format: :json
          end

          it "return http status code error" do
            expect(response).to have_http_status 400
          end
        end

        context "with valid token but without params" do
          before do
            request.headers['HTTP_AUTHORIZATION'] = token
            post :create, email_request: nil, format: :json
          end

          it "return http status code error" do
            expect(response).to have_http_status 400
          end
        end

        context "without access token" do
          before do
            post :create, email_request: nil, format: :json
          end

          it "return http status 401" do
            expect(response).to have_http_status 401
          end
        end

        context "with a invalid access token" do
          let(:invalid_token) do
            ActionController::HttpAuthentication::Token.encode_credentials("123")
          end

          before do
            request.headers['HTTP_AUTHORIZATION'] = invalid_token
            post :create, email_request: nil, format: :json
          end

          it "return http status 401" do
            expect(response).to have_http_status 401
          end
        end

      end
    end
  end
end
require "rails_helper"
module Api
   module V1
    describe EmailRequestsController, type: :controller do

      describe "POST create" do
        context "with valid params" do
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

          it "returns created status code (201)" do
            expect(response).to have_http_status(:created)
          end
        end

        context "with invalid params" do
          before do
            params = {
              "email_to" => nil,
              "template" => 1,
              "data" => {"name" => "Raphael Cuba"}
            }
            allow_any_instance_of(EmailRequest).to receive(:save).and_return false
            post :create, email_request: params, format: :json
          end

          it "return http status code error" do
            expect(response).to have_http_status 400
          end
        end

          end

          it "return http status code error" do
            expect(response).to have_http_status 400
          end

        end
      end

    end
  end
end
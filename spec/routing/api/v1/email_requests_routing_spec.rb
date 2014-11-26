require 'rails_helper'
module Api
  module V1
    describe EmailRequestsController, type: :routing do
      describe "routing" do
        it { expect( post: "/api/email_requests").to route_to("api/v1/email_requests#create", format: "json") }
        it { expect( get: "/api/email_requests").not_to be_routable }
        it { expect( put: "/api/email_requests/1").to_not be_routable }
        it { expect( patch: "/api/email_requests/1").to_not be_routable }
        it { expect( delete: "/api/email_requests/1").to_not be_routable }
      end
    end
  end
end
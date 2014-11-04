require 'rails_helper'

RSpec.describe NotificationsController, :type => :controller do

  describe "POST create" do

    let(:email_report) {
      build(:email_report)
    }

    before do
      allow_any_instance_of(NotificationsController).to receive(:create_email_report).and_return(email_report)
      post :create, email_report: email_report.attributes
    end

    it "returns http success" do
      expect(response).to be_success
    end

    it "save email report" do
      expect(assigns(:email_report).attributes).to eql(email_report.attributes)
    end

  end

end

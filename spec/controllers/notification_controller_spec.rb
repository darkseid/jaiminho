require 'rails_helper'

RSpec.describe NotificationController, :type => :controller do

  describe "GET create" do
    it "returns http success" do
      get :create
      expect(response).to be_success
    end
  end

end

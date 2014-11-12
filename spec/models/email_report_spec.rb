require 'rails_helper'

RSpec.describe EmailReport, :type => :model do

  describe "validations" do

    it { should validate_presence_of :email_to }
    it { should validate_presence_of :template_name }
    it { should validate_presence_of :status }

  end

  describe "default values" do

    it "status should be equal :sending" do
      email_report = EmailReport.create email_to: "EMAIL", template_name: "TEMPLATE"
      expect(email_report.status).to eq("sending")
    end

  end

end

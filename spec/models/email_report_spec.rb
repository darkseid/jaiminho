require "rails_helper"

RSpec.describe EmailReport, type: :model do

  describe "api" do
    it { expect(EmailReport).to respond_to :get_by_status_and_email_template_id  }
  end

  describe "validations" do

    it { should validate_presence_of :email_to }
    it { should validate_presence_of :email_template }
    it { should validate_presence_of :status }

  end

  describe "default values" do

    let :email_template do
      EmailTemplate.create(name: "NAME", subject: "SUBJECT",
                           body: "BODY")
    end

    it "status should be equal :sending" do

      email_report = EmailReport.create(email_to: "EMAIL",
                                        email_template: email_template)
      expect(email_report.status).to match "sending"
    end

    it "status must not be equal :sending after get an instance \
        with status :failed" do
      EmailReport.create(email_to: "EMAIL",
                         email_template: email_template,
                         status: :failed)

      email_report = EmailReport.where(status: EmailReport.statuses[:failed])
      expect(email_report).to_not be_nil
    end
  end
end

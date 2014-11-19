require "rails_helper"

describe EmailRequest, type: :model do

  describe "api" do
    it { expect(EmailRequest).to respond_to :get_by_status_and_email_template_id  }
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

      email_request = EmailRequest.create(email_to: "EMAIL",
                                          email_template: email_template)
      expect(email_request.status).to match "sending"
    end

    it "status must not be equal :sending after get an instance \
        with status :failed" do
      EmailRequest.create(email_to: "EMAIL",
                          email_template: email_template,
                          status: :failed)

      email_request = EmailRequest.where(status: EmailRequest.statuses[:failed])
      expect(email_request).to_not be_nil
    end
  end
end

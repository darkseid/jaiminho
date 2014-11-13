require "rails_helper"

RSpec.describe EmailReport, type: :model do

  describe "validations" do

    it { should validate_presence_of :email_to }
    it { should validate_presence_of :email_template }
    it { should validate_presence_of :status }

  end

  describe "creating with default values" do

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

  describe "duplicate an instance" do

    let(:email_report) do
      build(:email_report_with_id, email_to: "SHOULD_BE_DUPLICATED")
    end

    let(:duplicated) do
      @duplicated = EmailReport.duplicate email_report.id
    end

    before do
      allow(EmailReport).to receive(:find).and_return email_report
    end

    it "duplicated email_report should has the same email_template_id" do
      expect(duplicated.email_template_id).to \
        eq(email_report.email_template_id)
    end

    it "duplicated email_report should has the same email_to" do
      expect(duplicated.email_to).to eq(email_report.email_to)
    end

    it "duplicated email_report should has the same data" do
      expect(duplicated.data).to eq(email_report.data)
    end

    it "duplicated email_report should has the same reply_to" do
      expect(duplicated.reply_to).to eq(email_report.reply_to)
    end

    it "duplicated email_report should has the same cc" do
      expect(duplicated.cc).to eq(email_report.cc)
    end

    it "duplicated email_report should has the same bcc" do
      expect(duplicated.bcc).to eq(email_report.bcc)
    end

    it "duplicated email_report should not have the same id" do
      expect(duplicated.id).not_to eq(email_report.id)
    end

    it "initial status should be :sending" do
      expect(duplicated.status).to match 'sending'
    end
  end
end

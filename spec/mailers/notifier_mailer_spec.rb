require "rails_helper"

RSpec.describe NotifierMailer, :type => :mailer do

  describe ".notify" do

    context "email_report_id is required" do

      it "throws an ArgumentError if email_report_id is not informed" do
        expect { NotifierMailer.notify(nil) }.to raise_error ArgumentError
      end

      it "does not throw an ArgumentError if email_report_id is informed" do
        expect { NotifierMailer.notify(9999999) }.to raise_error ActiveRecord::RecordNotFound
      end

    end

    context "sends email" do

      let(:email_report) {
        build(:email_report_with_id, template_name: 'template_name_test', data: {test: "Text", subject: "User"}, email_to: ["email@test.com", "test@email.com"])
      }

      before :example do
        notification_template = EmailTemplate.new name: "template_name_test", body: "<h1><%= data[:test] %></h1>", subject: "Testing, <%= data[:subject] %>"
        allow_any_instance_of(NotifierMailer).to receive(:get_template_with_name).and_return notification_template
        allow(EmailReport).to receive(:find).and_return email_report
        @email = NotifierMailer.notify email_report.id
      end

      it { expect(ActionMailer::Base.deliveries).not_to be_empty }

      it "renders the body" do
        expect(@email.body.to_s).to match "<h1>Text</h1>"
      end

      it "renders the subject" do
        expect(@email.subject).to match "Testing, User"
      end

      it "from correct email" do
        expect(@email.from).to eq([MAILER_CONFIG["from"]])
      end

      it "to list right" do
        expect(@email.to).to eq(["email@test.com", "test@email.com"])
      end

      it "change email_report status when email is sent" do
        expect(email_report.status).to eq("success")
      end

    end

  end

end

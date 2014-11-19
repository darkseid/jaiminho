require "rails_helper"

RSpec.describe NotifierMailer, :type => :mailer do

  describe ".notify" do

    context "email_request_id is required" do

      it "throws an ArgumentError if email_request_id is not informed" do
        expect { NotifierMailer.notify(nil) }.to raise_error ArgumentError
      end

      it "does not throw an ArgumentError if email_request_id is informed" do
        expect { NotifierMailer.notify(9999999) }.to raise_error ActiveRecord::RecordNotFound
      end

    end

    context "sends email" do

      let(:email_template) {
        build :email_template, name: "template_name_test", body: "<h1><%= data[:test] %></h1>", subject: "Testing, <%= data[:subject] %>"
      }

      let(:email_request) {
        build :email_request, id: 0, email_template: email_template, data: {test: "Text", subject: "User"}, email_to: ["email@test.com", "test@email.com"]
      }

      before :example do
        allow(EmailTemplate).to receive(:find_by_name!).and_return email_template
        allow(EmailRequest).to receive(:find).and_return email_request
        @email = NotifierMailer.notify email_request.id
      end

      it { expect(ActionMailer::Base.deliveries).not_to be_empty }

      it "renders the body" do
        expect(@email.body.to_s).to match "<h1>Text</h1>"
      end

      it "renders the subject" do
        expect(@email.subject).to match "Testing, User"
      end

      it "from correct email" do
        expect(@email.from).to eq [MAILER_CONFIG["from"]]
      end

      it "to list right" do
        expect(@email.to).to eq ["email@test.com", "test@email.com"]
      end

      it "change email_request status when email is sent" do
        expect(email_request.status).to match "success"
      end

    end

  end

end

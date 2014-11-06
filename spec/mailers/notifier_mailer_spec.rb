require "rails_helper"

RSpec.describe NotifierMailer, :type => :mailer do

  describe ".notify" do

    context "email_to and template_name are required" do

      it "throws an ArgumentError if email_to is not informed" do
        expect { NotifierMailer.notify(nil, "template_name") }.to raise_error ArgumentError
      end

      it "throws an ArgumentError if template_name is not informed" do
        expect { NotifierMailer.notify("email@domain.com", nil) }.to raise_error ArgumentError
      end

      it "does not throw an ArgumentError if both are informed" do
        expect { NotifierMailer.notify("email@domain.com", "template_name") }.to raise_error ActiveRecord::RecordNotFound
      end

    end

    context "sends email" do

      before :example do
        notification_template = EmailTemplate.new name: "template_name_test", body: "<h1><%= data[:test] %></h1>", subject: "Testing, <%= data[:subject] %>"
        allow_any_instance_of(NotifierMailer).to receive(:get_template_with_name).and_return notification_template
        @email = NotifierMailer.notify ["email@test.com", "test@email.com"], "template_name_test", {test: "Text", subject: "User"}
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

    end

  end

end

require "rails_helper"

RSpec.describe NotifierMailer, :type => :mailer do

  describe ".notify" do

    context "email_to and template_name are required" do

      it "throws an ArgumentError if email_to is not informed" do
        expect { NotifierMailer.notify(nil, 'template_name') }.to raise_error ArgumentError
      end

      it "throws an ArgumentError if template_name is not informed" do
        expect { NotifierMailer.notify('email@domain.com', nil) }.to raise_error ArgumentError
      end

      it "does not throw an ArgumentError if both are informed" do
        expect { NotifierMailer.notify('email@domain.com', 'template_name') }.to raise_error ActiveRecord::RecordNotFound
      end

    end

    context "sends email" do

      let!(:email) {
        NotifierMailer.notify 'email@test.com', 'template_name_test', {test: "Text"}
      }

      before :all do
        NotificationTemplate.create name: "template_name_test", body: "<h1><%= data[:test] %></h1>"
      end

      it { expect(ActionMailer::Base.deliveries).not_to be_empty }

      it "renders the body" do
        expect(email.body.to_s).to match "<h1>Text</h1>"
      end

    end

  end

end

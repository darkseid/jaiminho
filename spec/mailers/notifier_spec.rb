require "rails_helper"

RSpec.describe Notifier, :type => :mailer do

  describe "#notify" do

    context "email_to and template_name are required" do

      it "throws an ArgumentError if email_to is not informed" do
        expect { Notifier.notify(nil, 'template_name') }.to raise_error(ArgumentError)
      end

      it "throws an ArgumentError if template_name is not informed" do
        expect { Notifier.notify('email@domain.com', nil) }.to raise_error(ArgumentError)
      end

      it "does not throw an ArgumentError if both are informed" do
        expect { Notifier.notify('email@domain.com', 'template_name') }.to raise_error(ActiveRecord::RecordNotFound)
      end

    end
  end

  describe "notify" do
    let(:mail) { Notifier.notify }

    xit "renders the headers" do
      expect(mail.subject).to eq("Notify")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    xit "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end

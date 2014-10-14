require "rails_helper"

RSpec.describe Notifier, :type => :mailer do
  describe "#notify" do

    context "when email is not informed" do
      it "should throw an error" do
        expect {Notifier.notify}.to raise_error 
      end
    end

    context "when template_name is not informed" do
      it "should throw an error" do
        expect {Notifier.notify}.to raise_error 
      end
    end

    context "when the template does not exist" do
      it "raise an error" do
        expect {Notifier.notify('rafael@teste.com', 'template_inexistente')}.to raise_error
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

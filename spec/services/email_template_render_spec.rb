require "rails_helper"

describe EmailTemplateRender do

  let(:simple_email_template) { build(:email_template, :with_placeholder) }

  subject { EmailTemplateRender.new(simple_email_template, {}) }

  describe "api" do
    it { is_expected.to respond_to :subject }
    it { is_expected.to respond_to :body }
  end

  describe "initialize" do

    it "raises argument error if any parameters is missing" do
      expect { EmailTemplateRender.new }.to raise_error ArgumentError
    end

    it "do not raises argument error if the parameters given" do
      expect { EmailTemplateRender.new(simple_email_template, {}) }.not_to raise_error
    end
  end

  describe "#subject" do
    context "given simple email_template" do
      let(:renderer) { EmailTemplateRender.new(simple_email_template, data) } 
      let(:data) { {name: "João"} } 

      it "returns subject with data['name'] value" do
        expect(renderer.subject).to be == "Oi João"
      end
    end
  end

  describe "#body" do
    context "given simple email_template" do
      let(:data) { {product: "Caneta"} } 
      let(:renderer) { EmailTemplateRender.new(simple_email_template, data) } 

      it "returns body with data['product'] value" do
        expect(renderer.body).to be == "Obrigado por comprar Caneta"
      end
    end
  end
end

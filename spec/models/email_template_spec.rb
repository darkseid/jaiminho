require "rails_helper"

RSpec.describe EmailTemplate, type: :model do

  describe "validations" do
    it { should validate_uniqueness_of :name }
    it { should validate_presence_of :name }
    it { should validate_presence_of :body }
    it { should validate_presence_of :body }
    it { should validate_presence_of :subject }
  end

  it "inherits from NotificationTemplate" do
    expect(EmailTemplate.new).to be_a NotificationTemplate
  end

  describe "when name is already taken" do

    let :email_template do
      EmailTemplate.create(name: "NAME", subject: "SUBJECT", body: "BODY")
    end

    it "cannot be saved" do
      duplicated = email_template.dup
      expect(duplicated.save).to be false
    end
  end
end

require "rails_helper"

RSpec.describe NotificationTemplate, :type => :model do
  describe ".validations" do
    it { should validate_uniqueness_of :name}
    it { should validate_presence_of :name}
    it { should validate_presence_of :body}
    xit { should allow_value('email@domain.com').for(:to)}
    xit { should_not allow_value('email').for(:to)}
  end
end
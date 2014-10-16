require "rails_helper"

RSpec.describe NotificationTemplate, :type => :model do
  describe ".validations" do
    it { should validate_uniqueness_of :name}
    it { should validate_presence_of :name}
    it { should validate_presence_of :body}
  end
end
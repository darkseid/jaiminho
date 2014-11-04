require 'rails_helper'

RSpec.describe EmailReport, :type => :model do

  describe "validations" do

    it { should validate_presence_of :email_to }
    it { should validate_presence_of :template_name }
    it { should validate_presence_of :status }

  end

end

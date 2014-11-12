require 'rails_helper'

RSpec.describe EmailReport, type: :model do

  describe 'validations' do

    it { should validate_presence_of :email_to }
    it { should validate_presence_of :email_template }
    it { should validate_presence_of :status }

  end

  describe 'default values' do

    before do
      @email_template = EmailTemplate.create(name: 'NAME',
                                             subject: 'SUBJECT',
                                             body: 'BODY')
    end

    it 'status should be equal :sending' do

      email_report = EmailReport.create(email_to: 'EMAIL',
                                        email_template: @email_template)
      expect(email_report.status).to eq('sending')
    end

    it 'status must not be equal :sending after get an instance \
        with status :failed' do
      EmailReport.create(email_to: 'EMAIL',
                         email_template: @email_template,
                         status: :failed)

      email_report = EmailReport.where(status: EmailReport.statuses[:failed])
      expect(email_report).to_not be_nil
    end
  end
end

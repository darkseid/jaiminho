require 'rails_helper'

RSpec.describe EmailReportsController, type: :controller do
  describe 'GET #index' do

    context 'with populated database' do
      let(:email_report_1) { build(:email_report, created_at: Time.now - 10) }
      let(:email_report_2) { build(:email_report, created_at: Time.now) }

      before do
        allow(EmailReport).to receive(:order) \
          .and_return [email_report_1, email_report_2]
        get :index
      end

      it 'render :index template' do
        expect(response).to render_template :index
      end

      it 'should render an array with email_reports ordered desc' do
        expect(EmailReport).to have_received(:order).with created_at: :desc
      end

    end

  end
end

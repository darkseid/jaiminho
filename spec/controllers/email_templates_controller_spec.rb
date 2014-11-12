require 'rails_helper'

RSpec.describe EmailTemplatesController, :type => :controller do

    describe "GET #index" do

      context "with database populated" do

        let(:email_template) {
          create(:email_template)
        }

        before do
          get :index
        end

        it "populates an array of email templates" do
          expect(assigns(:email_templates)).to eq [email_template]
        end

        it "renders the :index template" do
          expect(response).to render_template :index
        end

      end

      context "with database empty" do
        it "returns an array of email templates empty"
      end

    end

    describe "GET #show" do

      let(:email_template) {
        create :email_template
      }

      context "when an email template exists" do

        before do
          get :show, id: email_template
        end

        it "assigns the requested email template to @email_template" do
          expect(assigns :email_template).to eq email_template
        end

        it "renders the :show template" do
          expect(response).to render_template :show
        end

      end

      context "when an email template is not found" do

        it "raise an error" do
          expect { get :show, id: 0 }.to raise_error
        end

      end

    end

    describe "GET #new" do

      before do
        get :new
      end

      it "assigns a new email template do @email_template" do
        expect(assigns :email_template).to be_a_new EmailTemplate
      end

      it "renders the :new template" do
        expect(response).to render_template :new
      end

    end

    describe "POST #create" do

      let(:hash_email_template) { attributes_for :email_template }

      context "with valid attributes" do

        it "saves the new email template in the database" do
          expect {
            post :create, email_template: hash_email_template
          }.to change(EmailTemplate, :count).by 1
        end

        it "reditects to email_templates#show" do
          post :create, email_template: hash_email_template
          expect(response).to redirect_to email_template_path assigns(:email_template)
        end

      end

      context "with invalid attributes" do

        let(:hash_invalid_email_template) { attributes_for :invalid_email_template }

        it "does not save the new email template in the database" do
          expect {
            post :create, email_template: hash_invalid_email_template
          }.to_not change(EmailTemplate, :count)
        end

        it "re-renders the :new template" do
          post :create, email_template: hash_invalid_email_template
          expect(response).to render_template :new
        end

      end

    end

    describe "PATCH #update" do

      let(:email_template) {
        create(:email_template)
      }

      context "valid attributes" do

        before do
          patch :update, id: email_template, email_template: attributes_for(:email_template, body: "My Body", subject: "My Subject")
        end

        it "located the requested @email_template" do
          expect(assigns(:email_template)).to eq email_template
        end

        it "changes @email_template's attributes" do
          email_template.reload
          expect(email_template.body).to eq "My Body"
          expect(email_template.subject).to eq "My Subject"
        end

        it "redirects to the updated email template" do
          expect(response).to redirect_to email_template
        end

      end

      context "invalid attributes" do

        before do
          patch :update, id: email_template, email_template: attributes_for(:email_template, body: nil, subject: "My Subject")
        end

        it "does not change the email template's attributes" do
          expect(email_template.subject).to_not eq "My Subject"
        end

        it "re-renders the edit template" do
          expect(response).to render_template :edit
        end

      end

    end

    describe "GET #edit" do

      let(:email_template) {
        create(:email_template)
      }

      context "with email template existing" do

        before :each do
          get :edit, id: email_template
        end

        it "renders the object" do
          expect(assigns :email_template).to eq email_template
        end

        it "renders the :edit template" do
          expect(response).to render_template :edit
        end

      end

      context "with email template not found" do

        it "returns record not found" do
          expect { get :edit, id: 0 }.to raise_error ActiveRecord::RecordNotFound
        end

      end

    end


  describe "DELETE #destroy" do

    before do
     @email_template = create :email_template
   end

    it "deletes the email template" do
      expect{
        delete :destroy, id: @email_template
      }.to change(EmailTemplate, :count).by -1
    end

    it "redirects to email_templates#index" do
      delete :destroy, id: @email_template
      expect(response).to redirect_to email_templates_url
    end

  end

end

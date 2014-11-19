FactoryGirl.define do
  factory :email_request do
    email_to Faker::Internet.email
    association :email_template, factory: :email_template
    data {}
    status EmailRequest.statuses[:success]

    factory :invalid_email_request do
      email_to nil
    end
  end
end

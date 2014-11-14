FactoryGirl.define do
  factory :email_report do
    email_to Faker::Internet.email
    association :email_template, factory: :email_template
    data {}
    status EmailReport.statuses[:success]

    factory :invalid_email_report do
      email_to nil
    end
  end
end

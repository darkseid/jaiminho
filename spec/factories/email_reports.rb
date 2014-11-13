FactoryGirl.define do
  factory :email_report do
    id nil
    email_to Faker::Internet.email
    association :email_template, factory: :email_template
    data {}
    status "success"

    factory :invalid_email_report do
      email_to nil
    end

    factory :email_report_with_id do
      id 0
    end
  end
end

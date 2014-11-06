FactoryGirl.define do
  factory :email_report do
    id nil
    email_to Faker::Internet.email
    template_name Faker::Internet.user_name
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

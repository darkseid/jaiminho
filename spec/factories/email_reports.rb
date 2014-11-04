FactoryGirl.define do
  factory :email_report do
    id nil
    email_to Faker::Internet.email
    template_name Faker::Internet.user_name
    data {}
    status nil
  end
end

FactoryGirl.define do
  factory :email_template do
    name { Faker::Internet.user_name }
    body { Faker::Lorem.paragraph }
    subject { Faker::Lorem.sentence }

    factory :invalid_email_template do
      name nil
      body nil
    end
  end
end

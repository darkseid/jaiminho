
FactoryGirl.define do
  factory :notification_template do
    id 0
    name { Faker::Internet.user_name }
    body { Faker::Lorem.paragraph }
    subject { Faker::Lorem.sentence }

    factory :invalid_notification_template do
      name nil
      body nil
    end
  end
end

FactoryGirl.define do
  factory :email_template do
    name { Faker::Internet.user_name }
    body { Faker::Lorem.paragraph }
    subject { Faker::Lorem.sentence }

    trait :with_placeholder do
      subject "Oi <%= data['name'] %>"
      body "Obrigado por comprar <%= data['product'] %>"
    end

    factory :invalid_email_template do
      name nil
      body nil
    end
  end
end

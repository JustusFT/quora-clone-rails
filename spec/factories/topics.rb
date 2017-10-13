FactoryGirl.define do
  factory :topic do
    name { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
  end
end

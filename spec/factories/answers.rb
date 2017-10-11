FactoryGirl.define do
  factory :answer do
    user
    question
    answer { Faker::Lorem.paragraph }
  end
end

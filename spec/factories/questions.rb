FactoryGirl.define do
  factory :question do
    user
    question { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
  end

  factory :invalid_question, parent: :question do
    question nil
  end
end

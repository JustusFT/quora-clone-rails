FactoryGirl.define do
  factory :user do
    full_name { Faker::Name.name }
    email { Faker::Internet.email }
    password "password"
    password_confirmation "password"
  end

  factory :invalid_user, parent: :user do |f|
    email nil
  end
end

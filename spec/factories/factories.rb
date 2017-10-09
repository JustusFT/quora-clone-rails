FactoryGirl.define do
  factory :user do
    full_name "John Doe"
    email "john@doe.com"
    password "password"
    password_confirmation "password"
  end
end

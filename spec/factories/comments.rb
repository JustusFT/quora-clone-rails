FactoryGirl.define do
  factory :comment do
    user
    answer
    parent_id nil
    comment { Faker::Lorem.paragraph }
  end

  factory :comment_reply, parent: :comment do
    parent_id { create(:comment).id }
  end
end

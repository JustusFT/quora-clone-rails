FactoryGirl.define do
  factory :vote do
    user
    vote_type { [:upvote, :downvote].sample }

    trait :question_vote do
      association :content, factory: :question
    end

    trait :answer_vote do
      association :content, factory: :answer
    end

    trait :comment_vote do
      association :content, factory: :comment
    end
  end
end

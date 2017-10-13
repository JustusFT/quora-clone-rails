require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(create(:user)).to be_valid
  end

  it "requires full_name" do
    expect(build(:user, full_name: nil)).to_not be_valid
  end

  it "will also delete it's questions when deleted" do
    user = create(:question).user
    expect { user.destroy }.to change(Question, :count).by(-1)
  end

  it "will also delete it's answers when deleted" do
    user = create(:answer).user
    expect { user.destroy }.to change(Answer, :count).by(-1)
  end

  it "will also delete it's comments when deleted" do
    user = create(:comment).user
    expect { user.destroy }.to change(Comment, :count).by(-1)
  end

  it "will also delete it's votes when deleted" do
    [:question_vote, :answer_vote, :comment_vote].each do |type|
      user = create(:vote, type).user
      expect { user.destroy }.to change(Vote, :count).by(-1)
    end
  end

  it "can subscribe to many topics" do
    user = create(:user)
    10.times do
      user.topics << create(:topic)
    end
    expect(user).to be_valid
  end
end

require 'rails_helper'

RSpec.describe Vote, type: :model do
  let(:types) { [:question_vote, :answer_vote, :comment_vote] }

  it "has a valid vote factory" do
    types.each do |type|
      expect(build(:vote, type)).to be_valid
    end
  end

  it "requires a user id" do
    types.each do |type|
      expect(build(:vote, type, user_id: nil)).to_not be_valid
    end
  end

  it "requires a content type" do
    types.each do |type|
      expect(build(:vote, type, content_type: nil)).to_not be_valid
    end
  end

  it "requires a content id" do
    types.each do |type|
      expect(build(:vote, type, content_id: nil)).to_not be_valid
    end
  end

  it "requires a vote type" do
    types.each do |type|
      expect(build(:vote, type, vote_type: nil)).to_not be_valid
    end
  end

  it "can only have a vote type equal to \"upvote\" or \"downvote\"" do
    types.each do |type|
      expect(build(:vote, type, vote_type: "upvote")).to be_valid
      expect(build(:vote, type, vote_type: "downvote")).to be_valid
      expect{build(:vote, type, vote_type: "asdf")}.to raise_error(ArgumentError)
    end
  end

  context "user" do
    it "can only vote on a content once" do
      types.each do |type|
        vote = create(:vote, type)
        vote2 = vote.dup
        expect(vote2).not_to be_valid
      end
    end
  end
end

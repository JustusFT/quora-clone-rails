require 'rails_helper'

RSpec.describe Comment, type: :model do
  it "has a valid factory" do
    expect(create(:comment)).to be_valid
  end

  it "has a valid comment with reply factory" do
    expect(create(:comment_reply)).to be_valid
  end

  it "can belong to a comment" do
    comment = create(:comment)
    reply = create(:comment, parent_id: comment.id)
    expect(reply.parent).to eq(comment)
    expect(comment.replies.include?(reply)).to eq(true)
  end

  it "does not need to belong to a comment" do
    comment = create(:comment)
    expect(comment.parent_id).to eq(nil)
  end

  it "requiers a user" do
    expect(build(:comment, user_id: nil)).not_to be_valid
  end

  it "requires an answer" do
    expect(build(:comment, answer_id: nil)).not_to be_valid
  end

  it "cannot be too long" do
    expect(build(:comment, comment: "a" * 65537)).not_to be_valid
  end

  it "will delete it's votes if deleted" do
    comment = create(:vote, :comment_vote).content
    expect { comment.destroy }.to change(Vote, :count).by(-1)
  end
end

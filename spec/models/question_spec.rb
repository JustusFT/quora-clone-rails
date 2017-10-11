require 'rails_helper'

RSpec.describe Question, type: :model do
  it "has a valid factory" do
    expect(create(:question)).to be_valid
  end

  it "requires a user" do
    expect(build(:question, user_id: nil)).not_to be_valid
  end

  it "requires a question" do
    expect(build(:question, question: nil)).not_to be_valid
  end

  it "does not allow long questions" do
    expect(build(:question, question: "a" * 251)).not_to be_valid
  end

  it "will delete it's votes if deleted" do
    question = create(:vote, :question_vote).content
    expect { question.destroy }.to change(Vote, :count).by(-1)
  end
end

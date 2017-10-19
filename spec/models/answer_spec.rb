require 'rails_helper'

RSpec.describe Answer, type: :model do
  it "has a valid factory" do
    expect(create(:answer)).to be_valid
  end

  it "requiers a user" do
    expect(build(:answer, user_id: nil)).not_to be_valid
  end

  it "requires a question" do
    expect(build(:answer, question_id: nil)).not_to be_valid
  end

  it "requires an answer" do
    expect(build(:answer, answer: nil)).not_to be_valid
  end

  it "cannot answer the same question twice" do
    answer = create(:answer)
    expect(build(:answer, user_id: answer.user_id, question_id: answer.question_id)).not_to be_valid
  end

  it "cannot be too long" do
    expect(build(:answer, answer: "a" * 65537)).not_to be_valid
  end

  it "will delete it's votes if deleted" do
    answer = create(:vote, :answer_vote).content
    expect { answer.destroy }.to change(Vote, :count).by(-1)
  end

  it "will delete it's comments if deleted" do
    answer = create(:comment).answer
    expect { answer.destroy }.to change(Comment, :count).by(-1)
  end

  describe "#get_question" do
    let!(:answer) { create(:answer) }

    it "returns a question" do
      expect(answer.get_question).to be_an_instance_of(Question)
    end

    it "will return the question it belongs to" do
      expect(answer.get_question).to eq(answer.question)
    end
  end
end

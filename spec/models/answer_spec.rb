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
end
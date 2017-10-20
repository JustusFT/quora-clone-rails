require 'rails_helper'

RSpec.shared_examples "a votable" do |parameter|
  let!(:object) { create(parameter) }
  let!(:user) { create(:user) }

  before(:each) do
    sign_in user
  end

  it "can be upvoted" do
    expect {
      post :create, params: { "#{parameter}_id": object.id, vote: { vote_type: "upvote" } }
    }.to change(object.votes, :count).by 1
    expect(Vote.last.vote_type).to eq "upvote"
  end

  it "can be downvoted" do
    expect {
      post :create, params: { "#{parameter}_id": object.id, vote: { vote_type: "downvote" } }
    }.to change(object.votes, :count).by 1
    expect(Vote.last.vote_type).to eq "downvote"
  end

  it "can switch upvote to downvote" do
    post :create, params: { "#{parameter}_id": object.id, vote: { vote_type: "upvote" } }
    expect(Vote.last.vote_type).to eq "upvote"
    expect {
      post :create, params: { "#{parameter}_id": object.id, vote: { vote_type: "downvote" } }
    }.not_to change(object.votes, :count)
    expect(Vote.last.vote_type).to eq "downvote"
  end

  it "can switch downvote to upvote" do
    post :create, params: { "#{parameter}_id": object.id, vote: { vote_type: "downvote" } }
    expect(Vote.last.vote_type).to eq "downvote"
    expect {
      post :create, params: { "#{parameter}_id": object.id, vote: { vote_type: "upvote" } }
    }.not_to change(object.votes, :count)
    expect(Vote.last.vote_type).to eq "upvote"
  end

  it "can delete votes" do
    vote = create(:vote, :"#{parameter}_vote", content: object)
    expect {
      delete :destroy, params: { id: vote.id }
    }.to change(object.votes, :count).by -1
  end
end

RSpec.describe VotesController, type: :controller do
  describe "Question" do
    include_examples "a votable", :question
  end

  describe "Answer" do
    include_examples "a votable", :answer
  end

  describe "Comment" do
    include_examples "a votable", :comment
  end
end

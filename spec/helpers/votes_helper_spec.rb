require 'rails_helper'

RSpec.describe VotesHelper, type: :helper do
  describe "#content_votes_url" do
    it "will return the proper url for questions" do
      question = create(:question)
      expect(helper.content_votes_url(question)).to eq(question_votes_url(question))
    end

    it "will return the proper url for answers" do
      answer = create(:answer)
      expect(helper.content_votes_url(answer)).to eq(answer_votes_url(answer))
    end

    it "will return the proper url for comments" do
      comment = create(:comment)
      expect(helper.content_votes_url(comment)).to eq(comment_votes_url(comment))
    end
  end

  describe "#current_vote" do
    context "signed in" do
      let!(:user) { create(:user) }

      before(:each) do
        sign_in user
      end

      it "will return the user's vote of the content" do
        question = create(:question)
        vote = create(:vote, :question_vote, content: question, user: user)
        expect(helper.current_vote(question)).to eq(vote)
      end

      it "will return nil if the user did not vote on the content" do
        question = create(:question)
        expect(helper.current_vote(question)).to eq(nil)
      end
    end

    context "signed out" do
      it "will return nil" do
        question = create(:question)
        expect(helper.current_vote(question)).to eq(nil)
      end
    end
  end

  describe "#has_vote?" do
    context "signed in" do
      let!(:user) { create(:user) }

      before(:each) do
        sign_in user
      end

      it "will return false if there is no vote" do
        question = create(:question)
        expect(helper.has_vote?(question)).to eq(false)
      end

      it "will return true if the user did vote" do
        vote = create(:vote, :question_vote, user: user)
        question = vote.content
        expect(helper.has_vote?(question)).to eq(true)
      end

      context "upvote" do
        it "will return true if the user upvoted" do
          vote = create(:vote, :question_vote, user: user, vote_type: "upvote")
          question = vote.content
          expect(helper.has_vote?(question, "upvote")).to eq(true)
        end

        it "will return false if the user downvoted" do
          vote = create(:vote, :question_vote, user: user, vote_type: "upvote")
          question = vote.content
          expect(helper.has_vote?(question, "downvote")).to eq(false)
        end
      end

      context "downvote" do
        it "will return false if the user upvoted" do
          vote = create(:vote, :question_vote, user: user, vote_type: "upvote")
          question = vote.content
          expect(helper.has_vote?(question, "downvote")).to eq(false)
        end

        it "will return true if the user downvoted" do
          vote = create(:vote, :question_vote, user: user, vote_type: "downvote")
          question = vote.content
          expect(helper.has_vote?(question, "downvote")).to eq(true)
        end
      end
    end

    context "signed out" do
      it "will return false" do
        question = create(:question)
        expect(helper.has_vote?(question)).to eq(false)
      end
    end
  end
end

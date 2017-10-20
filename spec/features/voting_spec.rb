require 'rails_helper'

describe "voting", type: :feature do
  describe "question", js: true do
    let!(:question) { create(:question) }
    let!(:user) { create(:user) }

    before(:each) do
      sign_in user
      visit question_path(question)
    end

    it "can be upvoted" do
      within "#question-content" do
        click_link("Upvote", exact: false)
      end
      expect(find("#question-content")).to have_content("Upvoted")
    end

    it "can remove upvote" do
      question.votes << create(:vote, :question_vote, user_id: user.id, vote_type: "upvote")
      page.driver.browser.navigate.refresh
      within "#question-content" do
        click_link("Upvoted", exact: false)
      end
      expect(find("#question-content")).to have_content("Upvote ")
    end

    it "can change upvote to downvote" do
      question.votes << create(:vote, :question_vote, user_id: user.id, vote_type: "upvote")
      page.driver.browser.navigate.refresh
      within "#question-content" do
        click_link("Downvote", exact: false)
      end
      expect(find("#question-content")).to have_content("Downvoted")
    end

    it "can be downvoted" do
      within "#question-content" do
        click_link("Downvote", exact: false)
      end
      expect(find("#question-content")).to have_content("Downvoted")
    end

    it "can remove downvote" do
      question.votes << create(:vote, :question_vote, user_id: user.id, vote_type: "downvote")
      page.driver.browser.navigate.refresh
      within "#question-content" do
        click_link("Downvoted", exact: false)
      end
      expect(find("#question-content")).to have_content("Downvote ")
    end

    it "can change downvote to upvote" do
      question.votes << create(:vote, :question_vote, user_id: user.id, vote_type: "downvote")
      page.driver.browser.navigate.refresh
      within "#question-content" do
        click_link("Upvote", exact: false)
      end
      expect(find("#question-content")).to have_content("Upvoted")
    end
  end
end

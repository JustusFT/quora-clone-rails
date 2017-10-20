require 'rails_helper'

describe "submitting an answer", type: :feature do
  context "user signed out" do
    it "will redirect to sign in page" do
      question = create(:question)
      visit question_url(question)
      expect(page).to have_current_path(new_user_session_path)
    end
  end

  context "user signed in" do
    it "can submit answer" do
      user = create(:user)
      sign_in user
      question = create(:question)
      visit question_url(question)
      answer = Faker::Lorem.paragraph
      within("#new_answer") do
        fill_in "Answer", with: answer
      end
      click_button "Answer"
      expect(page).to have_content answer
    end

    it "cannot submit 2 answers" do
      user = create(:user)
      sign_in user
      question = create(:question)
      visit question_url(question)
      answer = Faker::Lorem.paragraph
      within("#new_answer") do
        fill_in "Answer", with: answer
      end
      click_button "Answer"
      expect(page.has_css?("#new_answer")).to eq(false)
    end
  end
end

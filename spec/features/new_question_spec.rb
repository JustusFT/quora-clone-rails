require 'rails_helper'

describe "submitting a question", type: :feature do
  context "user signed out" do
    it "will redirect to sign in page" do
      visit new_question_url
      expect(page).to have_current_path(new_user_session_path)
    end
  end

  context "user signed in" do
    it "can submit question" do
      user = create(:user)
      sign_in user
      visit new_question_url
      question = Faker::Lorem.sentence
      description = Faker::Lorem.paragraph
      within("form") do
        fill_in "Question", with: question
        fill_in "Description", with: description
      end
      click_button "Create Question"
      expect(page).to have_content question
      expect(page).to have_content description
    end
  end
end

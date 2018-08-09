require 'rails_helper'

describe "submitting a question", type: :feature, js: true do
  context "user signed out" do
    it "will redirect to sign in page" do
      visit '/'
      expect(page).to have_current_path(new_user_session_path)
    end
  end

  context "user signed in" do
    it "can successfully submit a question" do
      user = create(:user)
      sign_in user
      visit '/'
      question = Faker::Lorem.sentence
      description = Faker::Lorem.paragraph
      click_button 'Ask Question'
      within 'form' do
        fill_in "Question", with: question
        fill_in "Description", with: description
      end
      click_button "Create Question"
      expect(page).to have_css('[data-test-id="question-page"]')
    end
  end
end


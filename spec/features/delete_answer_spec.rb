require 'rails_helper'

describe "delete form", type: :feature, js: true do
  let!(:answer) { create(:answer) }
  let(:question) { answer.question }
  let(:user) { answer.user }
  let(:edit_form_id) {"#edit_answer_#{answer.id}" }

  before(:each) do
    sign_in user
    visit question_path(question)
  end

  it "deletes the answer, and creates a form to create a new one" do
    within("#current-user-answer") do
      click_button "Delete"
      page.driver.browser.switch_to.alert.accept
    end
    expect(page).to have_css("#new_answer")
  end
end

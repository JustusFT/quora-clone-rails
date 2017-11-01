require 'rails_helper'

describe "edit form", type: :feature, js: true do
  let!(:answer) { create(:answer) }
  let(:question) { answer.question }
  let(:user) { answer.user }
  let(:edit_form_id) {"#edit_answer_#{answer.id}" }

  before(:each) do
    sign_in user
    visit question_path(question)
  end

  it "is initially hidden" do
    expect(page).not_to have_css(edit_form_id)
  end

  it "appears when the user clicks on the edit button" do
    page.find("#current-user-answer").click_button "Edit"
    expect(page).to have_css(edit_form_id)
  end

  it "has the user's current answer already filled in" do
    page.find("#current-user-answer").click_button "Edit"
    expect(page.find(edit_form_id)).to have_content(answer.answer)
  end

  it "can update the user's answer" do
    new_answer = build(:answer).answer
    page.find("#current-user-answer").click_button "Edit"
    within edit_form_id do
      fill_in "Answer", with: new_answer
      click_button "Update"
    end
    expect(page.find("#current-user-answer")).to have_content new_answer
  end

  it "disappears when the user discards changes" do
    page.find("#current-user-answer").click_button "Edit"
    within edit_form_id do
      click_button "Discard Changes"
    end
    expect(page).not_to have_css(edit_form_id)
  end

  it "resets the textarea to the user's original answer when the user discards changes" do
    new_answer = build(:answer).answer
    page.find("#current-user-answer").click_button "Edit"
    within edit_form_id do
      fill_in "Answer", with: new_answer
      click_button "Discard Changes"
    end
    page.find("#current-user-answer").click_button "Edit"
    expect(page.find(edit_form_id)).to have_content(answer.answer)
  end
end

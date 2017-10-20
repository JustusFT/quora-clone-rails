require 'rails_helper'

describe "the sign in process", type: :feature do
  let!(:user) { create(:user, password: "password") }

  it "signs me in" do
    visit new_user_session_url
    within("form") do
      fill_in "Email", with: user.email
      fill_in "Password", with: "password"
    end
    click_button "Log in"
    expect(page).to have_content "Signed in successfully."
  end
end

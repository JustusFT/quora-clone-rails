describe "the registration process", type: :feature do
  it "signs me in" do
    visit new_user_registration_url
    within("form") do
      fill_in "Full name", with: "John Doe"
      fill_in "Email", with: "email@example.com"
      fill_in "Password", with: "password"
      fill_in "Password confirmation", with: "password"
    end
    click_button "Sign up"
    expect(page).to have_content "Welcome! You have signed up successfully."
  end
end

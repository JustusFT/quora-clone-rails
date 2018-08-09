require 'rails_helper'

describe "the ask question modal", type: :feature, js: true do
  it 'is initially invisible' do
    user = create(:user)
    sign_in user
    visit '/'
    expect(page.find("#new-question-modal", visible: false).visible?).to be(false)
  end

  describe "from the navbar" do
    describe "clicking the ask question button" do
      it "opens the modal" do
        user = create(:user)
        sign_in user
        visit '/'
        find('[data-test-id="navbar-ask-question-button"]').click
        expect(page.find("#new-question-modal").visible?).to be(true)
      end
    end
  end

  describe "from the questions#index page" do
    describe 'clicking the "What is your question?" link' do
      it "opens the modal" do
        user = create(:user)
        sign_in user
        visit '/'
        find('[data-test-id="questions-index-ask-question-link"]').click
        expect(page.find("#new-question-modal").visible?).to be(true)
      end
    end
  end
end

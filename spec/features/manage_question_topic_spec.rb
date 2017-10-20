describe "managing a question's topics", type: :feature do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:question) { FactoryGirl.create(:question) }
  let!(:topic) { FactoryGirl.create(:topic) }

  before(:each) do
    sign_in user
    visit question_path(question)
    # open modal
    page.find("#show-topic-form").click
  end

  describe "Searching topics", js: true do
    it "will return matches" do
      # search for the first letter of the topic
      fill_in "Search topics", with: topic.name[0]
      expect(page.find('#topic-search-results')).to have_content topic.name
    end

    it "Will not return topics already belonging to the question" do
      question.topics << topic
      # refresh page to display new topic
      page.driver.browser.navigate.refresh
      # open modal again
      page.find("#show-topic-form").click
      # search for the first letter of the topic
      fill_in "Search topics", with: topic.name[0]
      expect(page.find('#topic-search-results')).not_to have_content topic.name
    end
  end

  describe "Adding topics", js: true do
    it "will add the topic to the question" do
      # search for the first letter of the topic
      fill_in "Search topics", with: topic.name[0]
      # click on the first autocomplete result
      page.find("#topic-search-results").first("a").click
      expect(page).to have_content "Topic added successfully"
    end
  end

  describe "Removing topics", js: true do
    it "can remove existing topics" do
      question.topics << topic
      # refresh page to display new topic
      page.driver.browser.navigate.refresh
      # open modal again
      page.find("#show-topic-form").click
      # remove first topic
      page.first(".remove-topic-link").click
      # accept the javascript confirmation prompt
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content "Topic removed successfully"
    end
  end
end

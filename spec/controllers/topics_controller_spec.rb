require 'rails_helper'

RSpec.describe TopicsController, type: :controller do
  describe "#follow" do
    it "can create a TopicUser" do
      topic = create(:topic)
      user = create(:user)
      sign_in user
      expect {
        post :follow, params: { topic_id: topic.id }
      }.to change(TopicUser, :count).by 1
    end
  end

  describe "#unfollow" do
    it "can remove a TopicUser" do
      topic = create(:topic)
      user = create(:user)
      sign_in user
      post :follow, params: { topic_id: topic.id }
      expect {
        delete :unfollow, params: { topic_id: topic.id }
      }.to change(TopicUser, :count).by -1
    end
  end
end

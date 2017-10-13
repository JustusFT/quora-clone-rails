require 'rails_helper'

RSpec.describe Topic, type: :model do
  it "has a valid factory" do
    expect(create(:topic)).to be_valid
  end

  it "can have many users" do
    topic = create(:topic)
    10.times do
      topic.users << create(:user)
    end
    expect(topic).to be_valid
  end

  it "can have many questions" do
    topic = create(:topic)
    10.times do
      topic.questions << create(:question)
    end
    expect(topic).to be_valid
  end
end

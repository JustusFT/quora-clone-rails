require 'rails_helper'

RSpec.describe User, type: :model do
  it "works" do
    user = build(:user)
    expect(user.full_name).to eq("John Doe")
  end

  it "requires full_name" do
    user = build(:user, full_name: nil)
    expect{user.save}.to raise_error(ActiveRecord::NotNullViolation)
  end
end

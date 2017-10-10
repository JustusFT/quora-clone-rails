require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(create(:user)).to be_valid
  end

  it "requires full_name" do
    expect(build(:user, full_name: nil)).to_not be_valid
  end
end

require 'rails_helper'

RSpec.describe User, type: :model do
  it "should have a factory" do
    expect(build(:user)).to be_valid
  end

  context "plugins" do
    it { should have_secure_password }
  end

  context "validations" do
    subject { create(:user) }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
    #it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_inclusion_of(:language).in_array(I18n.available_locales.map(&:to_s)) }
    it { should validate_inclusion_of(:time_zone).in_array(ActiveSupport::TimeZone.all.map(&:name)) }
  end

  context "public methods" do
    it "should regenerate a 32 characters long authentication token" do
      user = create(:user)
      authentication_token = user.authentication_token
      expect(user.regenerate_authentication_token).not_to eq(authentication_token)
    end
  end

  context "private methods" do
    it "should generate a 32 characters long authentication token after creation" do
      user = create(:user)
      expect(user.authentication_token.length).to eq(32)
    end
  end
end

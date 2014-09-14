require 'rails_helper'

RSpec.describe Invitation, type: :model do
  it "should have a factory" do
    expect(FactoryGirl.build(:invitation)).to be_valid
  end

  context "validations" do
    subject { FactoryGirl.create(:invitation) }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_inclusion_of(:language).in_array(I18n.available_locales.map(&:to_s)) }
    it { should validate_inclusion_of(:time_zone).in_array(ActiveSupport::TimeZone.all.map(&:name)) }
  end

  context "private methods" do
    it "should generate a 32 characters long token after creation" do
      invitation = FactoryGirl.create(:invitation)
      expect(invitation.token.length).to eq(32)
    end
  end
end

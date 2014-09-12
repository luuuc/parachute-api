require 'rails_helper'

RSpec.describe App, type: :model do
  it "should have a factory" do
    expect(FactoryGirl.build(:app)).to be_valid
  end

  context "validations" do
    subject { FactoryGirl.create(:app) }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end
end

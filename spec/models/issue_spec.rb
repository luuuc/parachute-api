require 'rails_helper'

RSpec.describe Issue, type: :model do
  it "should have a factory" do
    expect(build(:issue)).to be_valid
  end

  context "relationships" do
    subject { create(:issue) }

    it { should belong_to(:app) }
    it { should have_one(:backtrace) }
    it { should have_many(:occurences) }
  end

  context "validations" do
    subject { create(:issue) }

    it { should validate_presence_of(:app) }
    it { should validate_presence_of(:fingerprint) }
    it { should validate_uniqueness_of(:fingerprint).scoped_to(:app_id) }
  end
end

require 'rails_helper'

RSpec.describe Watcher, type: :model do


  it "should have a factory" do
    expect(FactoryGirl.build(:watcher)).to be_valid
  end

  context "relationships" do
    subject { FactoryGirl.create(:watcher) }

    it { should belong_to(:user) }
    it { should belong_to(:app) }
  end
end

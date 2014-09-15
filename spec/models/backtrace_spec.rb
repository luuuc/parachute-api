require 'rails_helper'

RSpec.describe Backtrace, type: :model do
  it "should have a factory" do
    expect(build(:backtrace)).to be_valid
  end
end

require 'rails_helper'

RSpec.describe Occurence, type: :model do
  it "should have a factory" do
    expect(build(:occurence)).to be_valid
  end
end

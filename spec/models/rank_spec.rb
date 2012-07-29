require 'spec_helper'

describe Rank do

  subject do
    FactoryGirl.build :rank
  end

  it 'is valid given the proper values' do
    should be_valid
  end

  describe '::highest' do
    it 'returns the highest rank of the given user in the given universe'
    it "adds the lowest rank of the given universe to the given user case he/she doesn't have one"
  end
end

require 'spec_helper'

describe Vote do
  subject do
    FactoryGirl.build :vote
  end

  it 'is valid given the proper values' do
    should be_valid
  end
end

require 'spec_helper'

describe Venue do
  subject do
    FactoryGirl.build :venue
  end

  it 'is valid given the proper values' do
    should be_valid
  end
end

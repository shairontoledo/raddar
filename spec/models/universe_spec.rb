require 'spec_helper'

describe Universe do
  subject do
    FactoryGirl.build :universe
  end

  it 'is valid given the proper values' do
    should be_valid
  end
end

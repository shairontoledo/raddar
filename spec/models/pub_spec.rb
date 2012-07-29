require 'spec_helper'

describe Pub do
  subject do
    FactoryGirl.build :pub
  end

  it 'is valid given the proper values' do
    should be_valid
  end
end

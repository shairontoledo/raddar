require 'spec_helper'

describe Watching do
  subject do
    FactoryGirl.build :watching
  end

  it 'is valid given the proper values' do
    should be_valid
  end
end

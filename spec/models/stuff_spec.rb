require 'spec_helper'

describe Stuff do
  subject do
    FactoryGirl.build :stuff
  end

  it 'is valid given the proper values' do
    should be_valid
  end
end

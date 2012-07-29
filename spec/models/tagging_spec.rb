require 'spec_helper'

describe Tagging do
  subject do
    FactoryGirl.build :tagging
  end

  it 'is valid given the proper values' do
    should be_valid
  end
end

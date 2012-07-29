require 'spec_helper'

describe Topic do
  subject do
    FactoryGirl.build :topic
  end

  it 'is valid given the proper values' do
    should be_valid
  end
end

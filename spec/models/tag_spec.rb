require 'spec_helper'

describe Tag do
  subject do
    FactoryGirl.build :tag
  end

  it 'is valid given the proper values' do
    should be_valid
  end
end

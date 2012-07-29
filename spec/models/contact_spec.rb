require 'spec_helper'

describe Contact do
  let :contact do
    FactoryGirl.build :contact
  end

  it 'is valid given the proper values' do
    contact.should be_valid
  end

  describe '#name' do
    it 'is required' do
      contact.name = nil
      contact.should_not be_valid
    end

    it 'returns the user name if present' do
      a_name = 'volmer'
      contact.name = a_name
      contact.user = nil
      contact.name.should == a_name

      contact.user = FactoryGirl.create :user, name: 'volmerius'
      contact.name.should == contact.user.name
    end
  end

  describe '#email' do
    it 'is required' do
      contact.email = nil
      contact.should_not be_valid
    end

    it 'has a proper format' do
      contact.email = 'xyzwky'
      contact.should_not be_valid
    end
  end

  describe '#message' do
    it 'is required' do
      contact.message = nil
      contact.should_not be_valid
    end

    it 'has a maximum lenght of 6_000' do
      contact.message = 6_001.times.map{'e'}.join
      contact.should_not be_valid
    end
  end
end

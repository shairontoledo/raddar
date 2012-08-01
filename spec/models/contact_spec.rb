require 'spec_helper'

describe Contact do

  subject { FactoryGirl.build :contact }

  it { should be_valid }

  it { should be_a_raddar_model }

  describe '#name' do
    it 'is required' do
      should validate_presence_of(:name)
    end

    it 'returns the user name if present' do
      a_name = 'volmer'
      subject.name = a_name
      subject.user = nil
      subject.name.should == a_name

      subject.user = FactoryGirl.create :user, name: 'volmerius'
      subject.name.should == subject.user.name
    end
  end

  describe '#email' do
    it 'is required' do
      should validate_presence_of(:email)
    end

    it 'has a proper format' do
      should validate_format_of(:email).with_format(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i)
    end
  end

  describe '#message' do
    it 'is required' do
      should validate_presence_of(:message)
    end

    it 'has a maximum lenght of 6_000' do
      should validate_length_of(:message).with_maximum(6_000)
    end
  end
end

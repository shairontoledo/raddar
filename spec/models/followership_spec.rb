require 'spec_helper'

describe Followership do
  subject do
    FactoryGirl.build :followership
  end

  it 'is valid given the proper values' do
    should be_valid
  end

  describe '#user' do
    it 'is a relation with User' do
      should belong_to(:user).as_inverse_of(:followerships)
    end

    it 'is required' do
      should validate_presence_of(:user)
    end
  end

  describe '#followable' do
    it 'is a relation with a followable resource' do
      should belong_to(:followable)
    end

    it 'is required' do
      should validate_presence_of(:followable)
    end

    it 'is unique for a single user' do
      should validate_uniqueness_of(:followable).scoped_to(:user_id)
    end
  end

  it 'is not valid if user == followable' do
    subject.followable = subject.user
    should_not be_valid
  end
end

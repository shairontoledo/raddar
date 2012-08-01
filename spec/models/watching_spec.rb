require 'spec_helper'

describe Watching do
  subject do
    FactoryGirl.build :watching
  end

  it { should be_valid }

  it { should be_a_raddar_model }

  describe '#user' do
    it 'is a relation with an user' do
      should belong_to(:user)
    end

    it 'is required' do
      should validate_presence_of(:user)
    end
  end

  describe '#watchable' do
    it 'is a relation with a watchable resource' do
      should belong_to(:watchable)
    end

    it 'is required' do
      should validate_presence_of(:watchable)
    end

    it 'is unique for a single user' do
      should validate_uniqueness_of(:watchable).scoped_on(:user_id)
    end
  end
end

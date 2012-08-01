require 'spec_helper'

describe Vote do
  subject do
    FactoryGirl.build :vote
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

  describe '#votable' do
    it 'is a relation with a votable resource' do
      should belong_to(:votable)
    end

    it 'is required' do
      should validate_presence_of(:votable)
    end

    it 'is unique for a single user' do
      should validate_uniqueness_of(:votable).scoped_on(:user_id)
    end
  end

  describe '#value' do
    it 'is required' do
      should validate_presence_of(:value)
    end

    it 'accpets :like and :dislike only' do
      should validate_inclusion_of(:value).to_allow([:like, :dislike])
    end
  end
end

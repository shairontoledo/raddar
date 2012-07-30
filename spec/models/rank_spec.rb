require 'spec_helper'

describe Rank do

  subject do
    FactoryGirl.build :rank
  end

  it 'is valid given the proper values' do
    should be_valid
  end

  describe '#universe' do
    it 'is a relation with an universe' do
      should belong_to(:universe)
    end

    it 'is required' do
      should validate_presence_of(:universe)
    end
  end

  describe '#user' do
    it 'is a relation with users' do
      should have_and_belong_to_many(:users)
    end
  end

  describe '#name' do
    it 'is required' do
      should validate_presence_of(:name)
    end

    it 'is unique for a single universe' do
      should validate_uniqueness_of(:name).scoped_to(:universe_id)
    end

    it 'has a maximum length of 30' do
      should validate_length_of(:name).with_maximum(30)
    end
  end

  describe '#level' do
    it 'is required' do
      should validate_presence_of(:level)
    end

    it { should validate_numericality_of(:level).to_allow(greater_than_or_equal_to: 1) }

    it 'is unique for a single universe' do
      should validate_uniqueness_of(:level).scoped_to(:universe_id)
    end
  end

  describe '#description' do
    it 'is required' do
      should validate_presence_of(:description)
    end

    it 'has a maximum length of 100' do
      should validate_length_of(:description).with_maximum(100)
    end
  end

  context 'when it is the last level of its universe' do
    before(:each) do
      subject.save!
    end

    it 'can be destroyed' do
      subject.destroy.should be_true
    end

    its(:is_last_level?) { should be_true }
  end

  context 'when it is not the last level of its universe' do
    before(:each) do
      subject.save!
      FactoryGirl.create :rank, universe: subject.universe
    end

    it 'cannot be destroyed' do
      subject.destroy.should be_false
    end

    its(:is_last_level?) { should be_false }
  end

  describe '#highest_users' do
    it 'returns users that it owns'
    it 'returns users that has the related rank as theirs highest rank in its universe'
    it 'returns users ordered by rank acquirance'
  end

  describe '::highest' do
    it 'returns the highest rank of the given user in the given universe'
    it "adds the lowest rank of the given universe to the given user case he/she doesn't have one"
  end
end

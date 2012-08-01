require 'spec_helper'

describe Rank do

  subject do
    FactoryGirl.build :rank
  end

  it { should be_valid }

  it { should be_a_raddar_model }

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

  context 'with users' do
    before :each do 
      @rank = FactoryGirl.create :rank
      @user = FactoryGirl.create :user
      @rank.users << @user
      @universe = @rank.universe
      @user.ranks << FactoryGirl.create(:rank, universe: @universe, level: (@rank.level + 1))
      @another_user = FactoryGirl.create :user
      @rank.users << @another_user
    end

    describe '#highest_users' do

      it 'returns users that has the related rank as theirs highest rank in its universe' do
        @rank.highest_users.should_not include(@user)
        @rank.highest_users.should include(@another_user)
      end

      it 'returns users ordered by descending rank acquirance date' do
        yet_another_user = FactoryGirl.create :user
        @rank.users << yet_another_user
        @rank.highest_users.should == [yet_another_user, @another_user]
      end
    end
  end

  describe '::highest' do
    before :each do
      @rank = FactoryGirl.create :rank
      @user = FactoryGirl.create :user
      @rank.users << @user
      @universe = @rank.universe
      @another_rank = FactoryGirl.create(:rank, universe: @universe, level: (@rank.level + 1))
      @user.ranks << @another_rank
    end

    it 'returns the highest rank of the given user in the given universe' do
      Rank.highest(@user, @universe).should == @another_rank
    end

    it "adds the lowest rank of the given universe to the given user case he/she doesn't have one" do
      another_user = FactoryGirl.create :user
      @rank.users << another_user

      Rank.highest(another_user, @universe).should == @rank
    end
  end
end

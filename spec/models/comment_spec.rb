require 'spec_helper'

describe Comment do
  subject do
    FactoryGirl.build :comment
  end

  it { should be_valid }

  it { should be_a_raddar_model }
  it { should be_votable }
  it { should be_searchable }

  describe '#user' do
    it 'is a relation with User' do
      should belong_to(:user)
    end

    it 'is required' do
      should validate_presence_of :user
    end
  end

  describe '#commentable' do

    it 'is a relation with a commentable resource' do
      should belong_to(:commentable)
    end

    it 'is required' do
      should validate_presence_of(:commentable)
    end
  end

  describe '#content' do
    it 'is required' do
      should validate_presence_of(:content)
    end

    it 'has a maximum length of 6_000' do
      should validate_length_of(:content).with_maximum(6_000)
    end
  end

  describe '#to_s' do
    it 'returns the value of #content' do
      subject.to_s.should == subject.content
    end
  end
end

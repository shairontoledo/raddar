require 'spec_helper'

describe Post do
  subject do
    FactoryGirl.build :post
  end

  it { should be_valid }

  it { should be_a_raddar_model }
  it { should be_votable }
  it { should be_searchable }

  describe '#topic' do
    it 'is a relation with a topic' do
      should belong_to(:topic)
    end

    it 'is required' do
      should validate_presence_of(:topic)
    end
  end

  describe '#user' do
    it 'is a relation with an user' do
      should belong_to(:user)
    end

    it 'is required' do
      should validate_presence_of(:user)
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

  describe '#url' do
    it 'returns the topic url with the #post_ID anchor in the url' do
      subject.url.should match(/^\/forums\/(.*?)\/topics\/(.*?)#post_#{subject.id}$/)
    end
  end

  describe '#to_s' do
    it 'returns the value of #content' do
      subject.to_s.should == subject.content
    end
  end
end

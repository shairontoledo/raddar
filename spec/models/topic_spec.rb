require 'spec_helper'

describe Topic do
  subject do
    FactoryGirl.build :topic
  end

  it 'is valid given the proper values' do
    should be_valid
  end

  describe '#user' do
    it 'is a relation with an user' do
      should belong_to(:user)
    end

    it 'is required' do
      should validate_presence_of(:user)
    end
  end

  describe '#forum' do
    it 'is a relation with a forum' do
      should belong_to(:forum)
    end

    it 'is required' do
      should validate_presence_of(:forum)
    end
  end

  describe '#name' do
    it 'is required' do
      should validate_presence_of(:name)
    end

    it 'has a maximum length of 100' do
      should validate_length_of(:name).with_maximum(100)
    end
  end

  describe '#first_posts' do
    it 'returns its posts ordered by the creation date' do
      subject.posts.should_receive(:order_by).with([:created_at, :asc])
      subject.first_posts
    end
  end
end

require 'spec_helper'

describe Tagging do
  subject do
    FactoryGirl.build :tagging
  end

  it 'is valid given the proper values' do
    should be_valid
  end

  describe '#tag' do
    it 'is a relation with a tag' do
      should belong_to(:tag)
    end

    it 'is required' do
      should validate_presence_of(:tag)
    end
  end

  describe '#taggable' do
    it 'is a relation with a taggable resource' do
      should belong_to(:taggable)
    end

    it 'is required' do
      should validate_presence_of(:taggable)
    end

    it 'is unique for a single tag' do
      should validate_uniqueness_of(:taggable).scoped_on(:tag_id)
    end
  end
end

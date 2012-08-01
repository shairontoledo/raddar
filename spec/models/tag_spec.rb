require 'spec_helper'

describe Tag do
  subject do
    FactoryGirl.build :tag
  end

  it { should be_valid }

  it { should be_a_raddar_model }

  it { should have_slug(:name) }

  it { should have_many(:taggings) }

  describe '#name' do
    it 'is required' do
      should validate_presence_of(:name)
    end

    it 'has a maximum length of 100' do
      should validate_length_of(:name).with_maximum(100)
    end

    it 'is unique (case insensitive)' do
      should validate_uniqueness_of(:name).case_insensitive
    end
  end
end

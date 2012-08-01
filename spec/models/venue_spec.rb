require 'spec_helper'

describe Venue do
  subject do
    FactoryGirl.build :venue
  end

  it 'is valid given the proper values' do
    should be_valid
  end

  it { should belong_to(:user) }

  it { should be_a_raddar_model }
  it { should be_taggable }
  it { should be_commentable }
  it { should be_watchable }
  it { should be_searchable }
  it { should be_votable }

  it { should have_slug(:name) }

  describe '#name' do
    it 'is required' do
      should validate_presence_of(:name)
    end

    it 'has a maximum length of 100' do
      should validate_length_of(:name).with_maximum(100)
    end
  end

  describe '#description' do
    it 'is required' do
      should validate_presence_of(:description)
    end

    it 'has a maximum length of 500' do
      should validate_length_of(:description).with_maximum(500)
    end
  end

  it{ should validate_length_of(:address).with_maximum(100) }
  it{ should validate_length_of(:city).with_maximum(100) }

  describe '#complete_address' do
    it 'includes its city' do
      subject.city = 'Gotham'
      subject.complete_address.should include(subject.city)
    end

    it 'includes its address' do
      subject.address = '5th Street, 45'
      subject.complete_address.should include(subject.address)
    end

    it 'includes its tags' do
      subject.tags = 'weird, creepy, dangerous'
      subject.to_s.should include(subject.tags)
    end
  end

  describe '#to_s' do
    it 'includes its name' do
      subject.to_s.should include(subject.name)
    end

    it 'includes its description' do
      subject.to_s.should include(subject.description)
    end

    it 'includes its city' do
      subject.city = 'Gotham'
      subject.to_s.should include(subject.city)
    end

    it 'includes its address' do
      subject.address = '5th Street, 45'
      subject.to_s.should include(subject.address)
    end

    it 'includes its tags' do
      subject.tags = 'weird, creepy, dangerous'
      subject.to_s.should include(subject.tags)
    end
  end
end

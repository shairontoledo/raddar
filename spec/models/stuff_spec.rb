require 'spec_helper'

describe Stuff do
  subject do
    FactoryGirl.build :stuff
  end

  it 'is valid given the proper values' do
    should be_valid
  end

  describe '#pub' do
    it 'is a relation with a pub' do
      should belong_to(:pub)
    end

    it 'is required' do
      should validate_presence_of(:pub)
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

  describe '#content' do
    it 'is required' do
      should validate_presence_of(:content)
    end

    it 'has a maximum length of 60_000' do
      should validate_length_of(:content).with_maximum(60_000)
    end
  end

  describe '#url' do
    it 'returns its url'
  end

  describe '#to_s' do
    it 'includes its name' do
      subject.to_s.should include(subject.name)
    end

    it 'includes its content' do
      subject.to_s.should include(subject.content)
    end

    it 'includes its tags' do
      subject.tags = 'weird, creepy, dangerous'
      subject.to_s.should include(subject.tags)
    end
  end
end

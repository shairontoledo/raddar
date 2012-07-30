require 'spec_helper'

describe Page do
  subject { FactoryGirl.build :page }

  it { should be_valid }

  describe '#name' do
    it 'is required' do
      should validate_presence_of(:name)
    end

    it 'has a maximum length of 100' do
      should validate_length_of(:name).with_maximum(100)
    end

    it 'is unique' do
      should validate_uniqueness_of(:name)
    end
  end

  describe '#title' do
    it 'has a maximum length of 200' do
      should validate_length_of(:title).with_maximum(200)
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
end

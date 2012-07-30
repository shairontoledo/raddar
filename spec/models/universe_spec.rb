require 'spec_helper'

describe Universe do
  subject do
    FactoryGirl.build :universe
  end

  it 'is valid given the proper values' do
    should be_valid
  end

  it { should have_many(:forums) }
  it { should have_many(:pubs) }
  it { should have_many(:ranks) }

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

    it 'has a maximum length of 6_000' do
      should validate_length_of(:description).with_maximum(6_000)
    end
  end

  describe '#highest_rank' do
    it 'returns its rank wich have the highest level value'
  end
end

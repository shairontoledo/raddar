require 'spec_helper'

describe Pub do
  subject do
    FactoryGirl.build :pub
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

  it { should have_many(:stuffs) }

  it { should belong_to(:universe) }

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

  describe '#subtitle' do
    it 'has a maximum length of 120' do
      should validate_length_of(:subtitle).with_maximum(120)
    end
  end

  describe '#last_stuffs' do
    it 'returns its stuffs ordered by the descendent creation date' do
      subject.stuffs.should_receive(:order_by).with([:created_at, :desc])
      subject.last_stuffs
    end
  end

  describe '#to_s' do
    it 'includes its name' do
      subject.to_s.should include(subject.name)
    end

    it 'includes its subtitle' do
      subject.subtitle = 'A nice subtitle'
      subject.to_s.should include(subject.subtitle)
    end

    it 'includes its description' do
      subject.to_s.should include(subject.description)
    end
  end
end

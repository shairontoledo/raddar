require 'spec_helper'

describe Role do
  subject { FactoryGirl.build :role }

  it { should be_valid }

  describe '#user' do
    it 'is a relation with users' do
      should have_and_belong_to_many(:users)
    end
  end

  describe '#name' do
    it 'is required' do
      should validate_presence_of(:name)
    end

    it 'only accepts :admin as value' do
      should validate_inclusion_of(:name).to_allow([:admin])
    end

    it 'is unique' do
      should validate_uniqueness_of(:name)
    end
  end 
end

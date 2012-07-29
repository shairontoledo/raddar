require 'spec_helper'

describe Role do
  let :role do
    FactoryGirl.build :role
  end

  it 'is valid given the proper values' do
    role.should be_valid
  end

  describe '#name' do
    it 'is required' do
      role.name = nil
      role.should_not be_valid
    end

    it 'is unique' do
      other_role = FactoryGirl.build :role
      other_role.save!
      role.name = other_role.name
      role.should_not be_valid
    end

    it 'only accepts :admin as value' do
      role.name = :admin
      role.should be_valid
      role.name = :hand_of_the_king
      role.should_not be_valid
    end
  end 
end

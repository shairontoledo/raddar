require 'spec_helper'

describe Account do
  let :account do
    FactoryGirl.build :account
  end

  it 'is valid given the proper values' do
    account.should be_valid
  end

  describe '#provider' do
    it 'is required' do
      account.provider = nil
      account.should_not be_valid
    end

    it 'is unique for the same user' do
      other_account = FactoryGirl.create :account
      account.user = other_account.user
      account.provider = other_account.provider
      account.should_not be_valid
    end
  end 

  describe '#token' do
    it 'is required' do
      account.token = nil
      account.should_not be_valid
    end

    it 'is unique for the same provider' do
      other_account = FactoryGirl.create :account
      account.provider = other_account.provider
      account.token = other_account.token
      account.should_not be_valid
    end
  end

  describe '#secret'

  describe '#name' do
    it 'is required' do
      account.name = nil
      account.should_not be_valid
    end

    it 'is unique for the same provider' do
      other_account = FactoryGirl.create :account
      account.provider = other_account.provider
      account.name = other_account.name
      account.should_not be_valid
    end
  end

  describe '#url' do
    it 'is required' do
      account.url = nil
      account.should_not be_valid
    end

    it 'is unique for the same provider' do
      other_account = FactoryGirl.create :account
      account.provider = other_account.provider
      account.url = other_account.url
      account.should_not be_valid
    end
  end

  describe '#url_privacy' do
    it 'is required' do
      account.url_privacy = nil
      account.should_not be_valid
    end

    it 'only accepts :public or :only_me' do
      account.url_privacy = :public
      account.should be_valid
      account.url_privacy = :only_me
      account.should be_valid
      account.url_privacy = :friends
      account.should_not be_valid
    end
  end
end

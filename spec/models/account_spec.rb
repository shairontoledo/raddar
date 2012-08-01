require 'spec_helper'

describe Account do
  subject { FactoryGirl.build :account }

  it { should be_valid }

  it { should be_a_raddar_model }

  describe '#provider' do
    it 'is required' do
      should validate_presence_of(:provider)
    end

    it 'is unique for the same user' do
      should validate_uniqueness_of(:provider).scoped_on(:user_id)
    end
  end 

  describe '#token' do
    it 'is required' do
      should validate_presence_of(:token)
    end

    it 'is unique for the same provider' do
      should validate_uniqueness_of(:token).scoped_on(:provider)
    end
  end

  describe '#secret'

  describe '#name' do
    it 'is required' do
      should validate_presence_of(:name)
    end

    it 'is unique for the same provider' do
      should validate_uniqueness_of(:name).scoped_on(:provider)
    end
  end

  describe '#url' do
    it 'is required' do
      should validate_presence_of(:url)
    end

    it 'is unique for the same provider' do
      should validate_uniqueness_of(:url).scoped_on(:provider)
    end
  end

  describe '#url_privacy' do
    it 'is required' do
      should validate_presence_of(:url_privacy)
    end

    it 'only accepts :public or :only_me' do
      should validate_inclusion_of(:url_privacy).to_allow([:public, :only_me])
    end
  end
end

require 'spec_helper'

describe Notification do
  subject do
    FactoryGirl.build :notification
  end

  it { should be_valid }

  it { should have_fields(:item_path, :image_path) }

  describe '#user' do
    it 'is a relation with an user' do
      should belong_to(:user)
    end

    it 'is required' do
      should validate_presence_of(:user)
    end
  end

  describe '#content' do
    it 'is required' do
      should validate_presence_of(:content)
    end

    it 'has a maximum length of 200' do
      should validate_length_of(:content).with_maximum(200)
    end
  end

  describe '#status' do
    it 'is required' do
      should validate_presence_of(:status)
    end

    it 'accepts :read and :unread only' do
      should validate_inclusion_of(:status).to_allow([:read, :unread])
    end
  end 

  describe '::read_all' do
    it 'marks all notifications of the given user as read'
  end

  describe '::all_unread' do
    it 'returns all unread notifications of the given user'
    it 'returns notifications ordered by descending date of creation'
  end
end

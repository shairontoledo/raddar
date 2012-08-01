require 'spec_helper'

describe Notification do
  subject do
    FactoryGirl.build :notification
  end

  it { should be_valid }

  it { should be_a_raddar_model }

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

  context 'Given an user with notifications' do
    let :user do
      FactoryGirl.create :user_with_notifications
    end

    describe '::read_all' do
      it 'marks all notifications of the given user as read' do
        Notification.read_all user
        Notification.all_unread(user).should be_empty
      end
    end

    describe '::all_unread' do
      it 'returns all unread notifications of the given user' do
        user.notifications = []
        read_notification = FactoryGirl.create :notification, status: :read
        unread_notification = FactoryGirl.create :notification, status: :unread
        user.notifications << read_notification
        user.notifications << unread_notification

        Notification.all_unread(user).should == [unread_notification]
      end

      it 'returns notifications ordered by descending date of creation' do
        Notification.all_unread(user).should be_ordered_by([:created_at, :desc])
      end
    end
  end
end

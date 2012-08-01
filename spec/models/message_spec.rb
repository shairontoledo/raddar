require 'spec_helper'
require 'pp'

describe Message do
  subject { FactoryGirl.build :message }

  it { should be_valid }

  it { should be_a_raddar_model }

  describe '#sender' do
    it 'is a relation with a sender' do
      should belong_to(:sender)
    end

    it 'is required' do
      should validate_presence_of(:sender)
    end

    it 'cannot be the same as the recipient' do
      subject.sender = subject.recipient
      should_not be_valid
    end
  end

  describe '#sender_status' do
    it 'is required' do
      should validate_presence_of(:sender_status)
    end

    it 'accepts :read, :unread and :deleted only' do
      should validate_inclusion_of(:sender_status).to_allow([:read, :unread, :deleted])
    end
  end    

  describe '#recipient' do
    it 'is a relation with a recipient' do
      should belong_to(:recipient)
    end

    it 'is required' do
      should validate_presence_of(:recipient)
    end
  end

  describe '#recipient_status' do
    it 'is required' do
      should validate_presence_of(:recipient_status)
    end

    it 'accepts :read, :unread and :deleted only' do
      should validate_inclusion_of(:recipient_status).to_allow([:read, :unread, :deleted])
    end
  end 

  describe '#content' do
    it 'is required' do
      should validate_presence_of(:content)
    end

    it 'has a maximum length of 2_000' do
      should validate_length_of(:content).with_maximum(2_000)
    end
  end

  context 'There are users with chats' do
    before :each do 
      @user_1 = FactoryGirl.create :user
      @user_2 = FactoryGirl.create :user
      @chat = FactoryGirl.create_list :message, 3, sender: @user_1, recipient: @user_2
      @chat += FactoryGirl.create_list :message, 3, sender: @user_2, recipient: @user_1
    end

    describe '::find_chat' do
      it 'returns all messages exchanged between two users' do
        Message.find_chat(@user_1, @user_2).should =~ @chat
      end
        
      it 'returns messages in creation order' do
        Message.find_chat(@user_1, @user_2).should be_ordered_by([:created_at, :asc])
      end
      
      context "when a message is given by the 'last' parameter" do
        it 'returns only messages older than the given message' do
          last = @chat[@chat.count / 2]
          Message.find_chat(@user_1, @user_2, last).each do |message|
            message.created_at.should < last.created_at
          end 
        end
      end
    end

    describe '::read_chat' do
      it 'marks messages to user_1 from user_2 as read' do
        Message.read_chat @user_1, @user_2
        Message.find_chat(@user_1, @user_2).each do |message|
          if message.sender == @user_2
            message.recipient_status.should == :read
          end
        end
      end
    end

    describe '::read_chats' do
      it 'marks all messages received by a particular user as read' do
        Message::read_chats @user_1
        Message.where(recipient_id: @user_1.id).each do |message|
          message.recipient_status.should == :read
        end
      end
    end 

    describe '::destroy_chat' do
      it 'marks all messages exchanged between two users as deleted' do
        Message.destroy_chat @user_1, @user_2
        Message.find_chat(@user_1, @user_2).should be_empty
      end
    end

    describe '::find_chats' do
      it 'returns an array ordered by the descending order of creation of the last message of each chat' do
        another_chat = FactoryGirl.create_list :message, 3, recipient: @user_1, sender: (FactoryGirl.create(:user))
        Message.find_chats(@user_1).should have(2).chats
        Message.find_chats(@user_1).first.should =~ another_chat
        Message.find_chats(@user_1).last.should =~ @chat
      end

      context 'when no status is given' do
        it 'returns all chats with all messages not marked as deleted' do
          deleted_msg = @chat.first
          deleted_msg.sender_status = :deleted
          deleted_msg.save!

          Message.find_chats(deleted_msg.sender).last.should_not include(deleted_msg)
        end
      end

      context 'when a status is given' do
        it 'returns only messages marked with the given status' do
          read_msg = @chat.first
          read_msg.recipient_status = :read
          read_msg.save!

          Message.find_chats(read_msg.recipient, :read).last.should include(read_msg)
        end
      end
    end

    describe '::count_unread_chats' do
      it 'counts the number of unread chats' do
        FactoryGirl.create_list :message, 3, recipient: @user_1, sender: (FactoryGirl.create(:user))
        Message.count_unread_chats(@user_1).should == 2
      end
    end
  end
end

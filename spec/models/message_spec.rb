require 'spec_helper'

describe Message do
  subject do
    FactoryGirl.build :message
  end

  it { should be_valid }

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

  describe '::find_chat' do
    it 'returns all messages exchanged between two users'
    it 'returns messages in creation order'
    
    context "when a message is given by the 'last' parameter" do
      it 'returns only messages older than the given message'
    end
  end

  describe '::read_chat' do
    it 'marks messages to user_1 from user_2 as read'
  end

  describe '::read_chats' do
    it 'marks all messages received by a particular user as read'
  end 

  describe '::destroy_chat' do
    it 'marks all messages exchanged between two users as deleted'
  end

  describe '::find_chats' do
    it 'returns an array ordered by the descending order of creation of the last message of each chat'

    context 'when no status is given' do
      it 'returns all chats with all messages not marked as deleted'
    end

    context 'when a status is given' do
      it 'returns only messages marked with the given status'
    end
  end

  describe '::count_unread_chats' do
    it 'counts the number of unread chats'
    it 'returns 1 for n messages of a single sender'
  end

end

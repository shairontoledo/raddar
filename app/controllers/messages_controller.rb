class MessagesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  # GET /messages
  # GET /messages.xml
  def index
    @user = User.find(params[:user_id])
    @messages = current_user.chat_with(@user)
    @message = Message.new
    @message[:edit_content] = ''
    respond_with(@messages)
  end

  def more
    @user = User.find(params[:user_id])
    last = Message.find(params[:last])
    @messages = current_user.chat_with(@user,last)
  end


  # POST /messages
  # POST /messages.xml
  def create
    @user = User.find(params[:user_id])
    @message = Message.new(params[:message])
    @message.sender = current_user
    @message.recipient = @user
    @message.save

    #redirect_to user_messages_path(@user)
  end


  def destroy_all
    @user = User.find(params[:user_id])
    current_user.destroy_chat_with(@user.id)
    redirect_to user_messages_path(@user)
  end

  def all
    @messages = current_user.all_chats

  end
end

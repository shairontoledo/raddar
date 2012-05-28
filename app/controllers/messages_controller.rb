require 'will_paginate/array'

class MessagesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  # GET /messages
  # GET /messages.xml
  def index
    @user = User.find(params[:user_id])
    if @user.id == current_user.id
      redirect_to @user
    else
      current_user.mark_chat_as_read_with @user.id
      @messages = current_user.chat_with(@user.id)
      @message = Message.new
      @message[:edit_content] = ''
      respond_with(@messages)
    end
  end

  def more
    @user = User.find(params[:user_id])
    last = Message.find(params[:last])
    @messages = current_user.chat_with(@user.id, last)
  end


  # POST /messages
  # POST /messages.xml
  def create
    @user = User.find(params[:user_id])
    @message = Message.new(params[:message])
    @message.sender = current_user
    @message.recipient = @user
    @message.save

    Delayed::Job.enqueue(NotifyMessageJob.new(@message.id), run_at: 1.hour.from_now) if @user.notify_messages
  end


  def destroy_all
    @user = User.find(params[:user_id])
    current_user.destroy_chat_with(@user)
    redirect_to user_messages_path(@user)
  end

  def all
    @chats = current_user.all_chats.paginate(page: params[:page], per_page: 10)

  end

  def read
    @user = User.find(params[:user_id])
    current_user.mark_chat_as_read_with @user.id
  end
end

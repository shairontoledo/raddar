require 'will_paginate/array'

class MessagesController < ApplicationController
  load_and_authorize_resource
  skip_load_resource only: [:destroy_all]

  # GET /messages
  # GET /messages.xml
  def index
    if params[:user_id].blank?
      @chats = current_user.all_chats.paginate(page: params[:page], per_page: 10)
      render 'all'
    else
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

  def read
    if params[:user_id].blank?
      current_user.mark_chats_as_read
    else
      @user = User.find(params[:user_id])
      current_user.mark_chat_as_read_with @user.id
    end
  end
end

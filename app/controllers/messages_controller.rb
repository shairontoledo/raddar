require 'will_paginate/array'

class MessagesController < ApplicationController
  load_and_authorize_resource
  skip_load_resource only: [:destroy_all]

  # GET /messages
  # GET /messages.xml
  def index
    if params[:user_id].blank?
      @messages = Message.find_last_messages(current_user).paginate(page: params[:page], per_page: 15)
      render 'all'
    else
      @user = User.find(params[:user_id])
      if @user.id == current_user.id
        redirect_to @user
      else
        Message.read_chat(current_user, @user)
        @messages = Message.find_chat(current_user, @user)
        @message = Message.new
        @message[:edit_content] = ''
        respond_with(@messages)
      end
    end
  end

  def more
    @user = User.find(params[:user_id])
    last = Message.find(params[:last])
    @messages = Message.find_chat(current_user, @user, last)
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
    @user = User.find params[:user_id]
    Message.destroy_chat current_user, @user
    redirect_to user_messages_path(@user)
  end

  def read
    if params[:user_id].blank?
      Message.read_chats current_user
    else
      @user = User.find(params[:user_id])
      Message.read_chat current_user, @user
    end
  end
end

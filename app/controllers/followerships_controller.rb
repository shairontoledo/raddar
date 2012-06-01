require 'will_paginate/array'

class FollowershipsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  # Followers
  def index
    @followable = find_followable
    @followers = @followable.followers.paginate(page: params[:page], per_page: 10)
  end

  # Current user starts following
  def create
    @followable = find_followable
    f = current_user.followerships.new(followable: @followable)

    if f.save

      if @followable.class == User
        notification = @followable.notifications.new content: I18n.t('notification.follower.html', author: current_user.name), item_path: current_user.url, image_path: current_user.avatar.thumb.url
        notification.save
        NoticeMailer.delay(queue: 'new_follower').new_follower_email(notification, current_user) if @followable.notify_followers
      elsif !(@followable[:user].blank?)
        notification = @followable.user.notifications.new content: I18n.t('notification.follower_item.html', author: current_user.name, item: @followable.name), item_path: current_user.url, image_path: current_user.avatar.thumb.url
        notification.save
      end

      flash[:notice] = t 'flash.followership.create', name: @followable.name
    else
      flash[:alert] = t 'flash.followership.error', name: @followable.name
    end

    redirect_to @followable.url
  end

  # Current user stops following
  def destroy
    @followable = find_followable
    @followable.followers.where(user_id: current_user.id).destroy_all

    redirect_to @followable.url, notice: t('flash.followership.destroy', name: @followable.name)
  end

  private

  def find_followable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end

require 'will_paginate/array'

class FollowersController < ApplicationController
  load_and_authorize_resource :followership, parent: false
  skip_load_resource
  
  # Followers
  def index
    @followable = find_followable
    @followers = @followable.followers.paginate(page: params[:page], per_page: 9)
  end

  # Current user starts following
  def create
    @followable = find_followable
    f = current_user.followerships.new(followable: @followable)

    if f.save

      if @followable.class == User
        notification = @followable.notifications.new content: I18n.t('notification.follower.html', author: current_user.name), item_path: current_user, image_path: current_user.image.thumb.url, author: current_user
        notification.save
        NoticeMailer.delay(queue: 'new_follower').new_follower_email(notification, current_user) if @followable.notify_followers
      elsif !(@followable[:user].blank?)
        notification = @followable.user.notifications.new content: I18n.t('notification.follower_item.html', author: current_user.name, item: @followable.name), item_path: current_user, image_path: current_user.image.thumb.url
        notification.save
      end

      flash[:notice] = t 'flash.followership.create', name: @followable.name
    else
      flash[:alert] = t 'flash.followership.error', name: @followable.name
    end

    redirect_to raddar_path(@followable)
  end

  # Current user stops following
  def destroy
    @followable = find_followable
    @followable.followers.where(user_id: current_user.id).destroy_all

    redirect_to raddar_path(@followable), notice: t('flash.followership.destroy', name: @followable.name)
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

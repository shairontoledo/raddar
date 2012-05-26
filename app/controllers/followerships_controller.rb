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
    current_user.followerships.create(followable: @followable)

    redirect_to @followable, notice: t('flash.followership.create', name: @followable.name)
  end

  # Current user stops following
  def destroy
    @followable = find_followable
    @followable.followers.where(user_id: current_user.id).destroy_all

    redirect_to @followable, notice: t('flash.followership.destroy', name: @followable.name)
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

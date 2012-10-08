class WatchingsController < ApplicationController
  load_and_authorize_resource
  skip_load_resource only: [:destroy]

  def destroy
    @watchable = find_watchable
    @watchable.watchings.where(user_id: current_user.id).destroy_all

    redirect_to raddar_path(@watchable), notice: t('flash.watching.destroyed')
  end

  private
  def find_watchable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end

class NotificationsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def show
    notification = Notification.find(params[:id])
    notification.update_attribute(:status, :read) unless notification.status == :read

    redirect_to notification.item_path
  end

  def index
    @notifications = current_user.notifications.order_by([:created_at, :desc]).paginate(page: params[:page], per_page: 10)

    respond_with @notifications
  end
end

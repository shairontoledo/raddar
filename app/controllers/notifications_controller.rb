class NotificationsController < ApplicationController
  load_and_authorize_resource through: :current_user
  skip_load_resource only: [:read]

  def show
    @notification.update_attribute(:status, :read) unless @notification.status == :read

    redirect_to @notification.item_path
  end

  def index
    @notifications = @notifications.order_by([:created_at, :desc]).paginate(page: params[:page], per_page: 10)
    current_user.read_notifications

    respond_with @notifications
  end

  def read
    current_user.read_notifications
  end

  def destroy
    @notification.destroy

    respond_with @notification
  end
end

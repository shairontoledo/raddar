module Raddar::Notifiable

  def self.included base
    base.send :has_many, :triggered_notifications, class_name: 'Notification', inverse_of: :notifiable, dependent: :destroy
  end
end
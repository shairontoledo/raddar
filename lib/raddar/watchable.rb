module Raddar::Watchable

  def self.included base
    base.send :has_many, :watchings, as: :watchable, dependent: :destroy
  end
end
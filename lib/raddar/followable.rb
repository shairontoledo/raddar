module Raddar::Followable

  def self.included base
    base.send :has_many, :followers, class_name: 'Followership', as: :followable, dependent: :destroy
  end
end
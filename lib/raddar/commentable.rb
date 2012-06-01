module Raddar::Commentable

  def self.included base
    base.send :has_many, :comments, as: :commentable, dependent: :destroy
  end
end
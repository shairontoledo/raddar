module Raddar::Votable

  def self.included base
    base.send :has_many, :votes, as: :votable, dependent: :destroy
  end
end
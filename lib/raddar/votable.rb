module Raddar::Votable

  def self.included base
    base.send :has_many, :votes, as: :votable, dependent: :destroy
  end


  def votes_result
    min_elegible = 3

    result = 1

    total_count = self.votes.size
    like_count = self.votes.where(value: :like).size
    dislike_count = self.votes.where(value: :dislike).size

    result += 1 if (total_count >= min_elegible) && (like_count > dislike_count)

    result
  end
end
class CalculateUserRanksJob
  BASE_POINTS   = 7
  POST_VALUE    = 1
  STUFF_VALUE   = 3
  COMMENT_VALUE = 1 

  def perform
    Universe.includes(:ranks).all.each do |universe|
      User.where(status: :active).each do |user|

        intended_level = user.highest_rank(universe).level + 1

        if intended_level <= universe.highest_rank.level
          points = calc_points user, universe
          level = calc_level points

          if level >= intended_level
            rank = universe.ranks.where(level: intended_level).first
            user.ranks << rank

            Delayed::Job.enqueue NotifyRankJob.new(user.id, rank.id)
          end
        end
      end 
    end
  end

  private

  def calc_points user, universe
    points = 0

    user.posts.each do |post|
      points += (POST_VALUE * post.votes_result) if post.topic.forum.universe_id == universe.id
    end

    user.pubs.where(universe_id: universe.id).includes(:stuffs).each do |pub|
      pub.stuffs.each do |stuff|
        points += (STUFF_VALUE * stuff.votes_result)
      end
    end

    user.comments.each do |comment|
      commentable = comment.commentable
      if (commentable === Stuff) && (commentable.pub.universe_id == universe.id)
        points += (COMMENT_VALUE * comment.votes_result)
      end
    end

    points
  end

  def calc_level points
    level = 1
    to_next = BASE_POINTS
    
    while points >= to_next
      to_next += (BASE_POINTS * (1.5 ** level)).to_i 
      level += 1
    end

    level
  end
end
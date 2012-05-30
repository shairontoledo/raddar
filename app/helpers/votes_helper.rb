module VotesHelper

  def vote_button votable, value
    vote = votable.votes.where(user_id: current_user.id).first if user_signed_in?

    icon = 'icon-thumbs-up' if value == :like
    icon = 'icon-thumbs-down' if value == :dislike

    path = eval "#{votable.class.name.underscore}_vote_path(votable, value: value)"
    votes_count = votable.votes.where(value: value).count

    btn_class = ['btn', 'vote']
    btn_class << 'disabled' unless user_signed_in?
    btn_class << value.to_s
    btn_class << 'voted' if((!vote.nil?) && (vote.value == value))



    return link_to path, 
      :class => btn_class.join(' '),
      method: :post,
      remote: true do
        raw "<i class=\"#{icon}\"></i>"+
        "<span class=\"counter\">#{votes_count}</span>"
    end
  end
end

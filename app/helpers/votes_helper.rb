module VotesHelper

  def vote_button votable, value
    vote = votable.votes.where(user_id: current_user.id).first if user_signed_in?

    icon = 'icon-thumbs-up' if value == :like
    icon = 'icon-thumbs-down' if value == :dislike

    path = polymorphic_path([votable, :vote], value: value)
    votes_count = votable.votes.where(value: value).count

    btn_class = ['btn', 'vote']
    btn_class << 'disabled' unless user_signed_in?
    btn_class << value.to_s
    btn_class << 'voted' if((!vote.nil?) && (vote.value == value))

    title = user_signed_in? ? t("vote.#{value}") : t('user.session.invite', action: t('vote.new')) 



    return link_to path, 
      :class => btn_class.join(' '),
      title: title,
      method: :post,
      remote: true do
        raw "<i class=\"#{icon}\"></i>"+
        "<span class=\"counter\">#{votes_count}</span>"
    end
  end
end

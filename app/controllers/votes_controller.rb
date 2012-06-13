class VotesController < ApplicationController
  load_and_authorize_resource

  def create
    @votable = find_votable
    @votable.votes.where(user_id: current_user.id).destroy_all
    @vote.votable = @votable
    @vote.value = params[:value]
    @vote.user = current_user
    @vote.save
  end

  private
  def find_votable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end

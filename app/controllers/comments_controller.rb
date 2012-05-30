class CommentsController < ApplicationController

  load_and_authorize_resource


  def create
    @commentable = find_commentable

    @comment = @commentable.comments.new params[:comment]
    @comment.user = current_user
    if @comment.save
      current_user.watchings.create(watchable: @commentable) if @commentable.watchable? && params[:watch] == 'yes'
      
      Delayed::Job.enqueue NotifyCommentJob.new(@comment.id)

      respond_with @comment, location: @commentable
    else
      eval("@#{@commentable.class.name.downcase} = @commentable")
      render "#{@commentable.class.name.downcase.pluralize}/show"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_with @comment, location: @comment.commentable
  end

  private
  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end

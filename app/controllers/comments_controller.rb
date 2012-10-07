class CommentsController < ApplicationController
  load_and_authorize_resource

  helper_method :comment_path


  def create
    @commentable = find_commentable

    @comment.commentable = @commentable
    @comment.user = current_user

    if @comment.save
      current_user.watchings.create(watchable: @commentable) if @commentable.watchable? && params[:watch] == 'yes'
      
      Delayed::Job.enqueue NotifyCommentJob.new(@comment.id)

      respond_with @comment, location: comment_path(@comment)
    else
      eval("@#{@commentable.class.name.underscore} = @commentable")
      render "#{@commentable.class.name.downcase.underscore}/show"
    end
  end

  def destroy
    @comment.destroy
    respond_with @comment, location: raddar_path(@comment.commentable)
  end

  def comment_path comment, options={}
    send (commentable.class.name.underscore + '_path').to_sym, anchor: 'comments'
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

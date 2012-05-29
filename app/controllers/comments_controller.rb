class CommentsController < ApplicationController
  load_and_authorize_resource

  def create
    @commentable = find_commentable

    @comment = @commentable.comments.new params[:comment]
    @comment.user = current_user
    @comment.save

    respond_with @comment, location: @commentable
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_with @comment, location: @comment.commentable
  end

  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end

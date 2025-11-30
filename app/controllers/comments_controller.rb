class CommentsController < ApplicationController

  before_action :require_admin!

  def index
    @comments = Comment.unapproved
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      flash[:success] = 'Comment approved!' if @comment.approved?
    end
    redirect_to comments_url
  end

  def rejected
    @comments = Comment.rejected
  end

  private

  def comment_params
    params.require(:comment).permit(:approved, :rejected)
  end
end

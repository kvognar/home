class CommentsController < ApplicationController

  before_action :require_admin!

  def index
    @comments = Comment.where(approved: false)
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(comment_params)
      flash[:success] = 'Comment approved!' if @comment.approved?
    else
      flash[:errors] = @comment.errors.full_messages
    end
    redirect_to comments_url
  end

  def comment_params
    params.require(:comment).permit(:approved)
  end
end

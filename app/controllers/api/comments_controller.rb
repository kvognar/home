class Api::CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.date = DateTime.now
    @comment.approved = false unless signed_in?

    unless params[:comment][:day_number].to_i == @comment.day.number
      render json: { errors: ["Hm, I'm not sure you're a human."] }, status: :unprocessable_entity
      return
    end

    if @comment.save
      session[:author] = @comment.author
      session[:author_email] = @comment.author_email
      render json: @comment, status: :ok
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:day_id, :parent_id, :author, :author_email, :body)
  end
end

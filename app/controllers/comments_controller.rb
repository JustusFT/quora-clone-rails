class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = Comment.new(comment_params)
    @comment.user = helpers.current_user

    unless @comment.user.nil?
      @comment.save
    end
  end

  def update
    @comment = Comment.find(params[:id])

    unless @comment.user != helpers.current_user
      @comment.attributes = update_comment_params
      @comment.save
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    unless @comment.user != helpers.current_user
      @comment.destroy
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:user_id, :answer_id, :comment_id, :comment)
  end

  def update_comment_params
    params.require(:comment).permit(:comment)
  end
end

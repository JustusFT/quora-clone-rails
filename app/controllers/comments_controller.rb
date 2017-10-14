class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @answer = Answer.find(params[:answer_id])
    @comment = @answer.comments.new(comment_params)
    @comment.user = helpers.current_user

    unless @comment.user.nil?
      @comment.save
    end

    redirect_to @answer.question
  end

  def update
    @comment = Comment.find(params[:id])

    unless @comment.user != helpers.current_user
      @comment.attributes = update_comment_params
      @comment.save
    end

    redirect_to @comment.answer.question
  end

  def destroy
    @comment = Comment.find(params[:id])

    unless @comment.user != helpers.current_user
      @comment.destroy
    end

    redirect_to @comment.answer.question
  end

  private
  def comment_params
    params.require(:comment).permit(:user_id, :answer_id, :comment_id, :parent_id, :comment)
  end

  def update_comment_params
    params.require(:comment).permit(:comment)
  end
end

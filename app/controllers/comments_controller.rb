class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @answer = Answer.find(params[:answer_id])
    @comment = @answer.comments.new(comment_params)
    @comment.user = helpers.current_user

    if @comment.save
      flash[:success] = "Comment created successfully"
    else
      flash[:warning] = "Failed to create comment"
    end

    redirect_to @answer.question
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.attributes = update_comment_params

    if @comment.user == helpers.current_user && @comment.save
      flash[:success] = "Comment updated successfully"
    else
      flash[:warning] = "Failed to update comment"
    end

    redirect_to @comment.answer.question
  end

  def destroy
    @comment = Comment.find(params[:id])

    if @comment.user == helpers.current_user && @comment.destroy
      flash[:success] = "Comment deleted successfully"
    else
      flash[:warning] = "Failed to delete comment"
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

class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answer.user = helpers.current_user

    if !helpers.current_user.nil? && @answer.save
      flash[:success] = "Answer created successfully"
    else
      flash[:warning] = "Failed to create answer"
    end

    respond_to do |format|
      format.js
      format.html { redirect_to @question }
    end
  end

  def update
    @answer = Answer.find(params[:id])
    @answer.attributes = answer_params

    if @answer.user == helpers.current_user && @answer.save
      flash[:success] = "Answer updated successfully"
    else
      flash[:warning] = "Failed to update answer"
    end

    respond_to do |format|
      format.js
      format.html { redirect_to @answer.question }
    end
  end

  def destroy
    @answer = Answer.find(params[:id])

    if @answer.user == helpers.current_user && @answer.destroy
      flash[:success] = "Answer deleted successfully"
    else
      flash[:warning] = "Failed to delete answer"
    end

    respond_to do |format|
      format.js
      format.html { redirect_to @answer.question }
    end
  end

  private
  def answer_params
    params.require(:answer).permit(:user_id, :question_id, :answer)
  end
end

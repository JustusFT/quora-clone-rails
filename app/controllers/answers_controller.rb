class AnswersController < ApplicationController
  def create
    @answer = Answer.new(answer_params)
    @answer.user = helpers.current_user

    unless helpers.current_user.nil?
      @answer.save
    end

    redirect_to @answer.question
  end

  def update
    @answer = Answer.find(params[:id])
    @answer.attributes = answer_params

    unless @answer.user != helpers.current_user
      @answer.save
    end

    redirect_to @answer.question
  end

  def destroy
    @answer = Answer.find(params[:id])

    unless @answer.user != helpers.current_user
      @answer.destroy
    end

    redirect_to @answer.question
  end

  private
  def answer_params
    params.require(:answer).permit(:user_id, :question_id, :answer)
  end
end

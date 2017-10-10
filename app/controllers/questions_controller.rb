class QuestionsController < ApplicationController
  def create
    @question = Question.new(strong_params)
    @question.user = helpers.current_user

    if @question.user.nil?
      redirect_to root_url
    elsif @question.save
      redirect_to @question
    else
      render :new
    end
  end

  def update
    @question = Question.find(params[:id])
    @question.attributes = strong_params

    if @question.user != helpers.current_user
      redirect_to @question
    elsif @question.save
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:id])

    if @question.destroy!
      redirect_to questions_path
    else
      redirect_to @question
    end
  end

  private

  def strong_params
    params.require(:question).permit(:question, :description)
  end
end

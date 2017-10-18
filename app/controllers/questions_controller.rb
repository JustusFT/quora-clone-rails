class QuestionsController < ApplicationController
  before_action :authenticate_user!

  def add_topic
    @question = Question.find(params[:question_id])
    topic = Topic.find(params[:topic_id])
    @question.topics << topic
    flash[:success] = "Topic added successfully"
    redirect_to @question
  end

  def remove_topic
    @question = Question.find(params[:question_id])
    topic = Topic.find(params[:topic_id])
    @question.topics.delete(topic)
    flash[:success] = "Topic removed successfully"
    redirect_to @question
  end

  def new
    @question = Question.new
  end

  def edit
    @question = Question.find(params[:id])
  end

  def index
    @questions = Question.page(params[:page] || 1)
    @questions = @questions.topic(params[:topic_id]) if params[:topic_id]
  end

  def show
    @question = Question.find(params[:id])
  end

  def create
    @question = Question.new(strong_params)
    @question.user = helpers.current_user

    if @question.save
      flash[:success] = "Question created successfully"
      redirect_to @question
    else
      flash[:warning] = "Failed to create question"
      render :new
    end
  end

  def update
    @question = Question.find(params[:id])
    @question.attributes = strong_params

    if @question.user != helpers.current_user
      redirect_to @question
    elsif @question.save
      flash[:success] = "Question updated successfully"
      redirect_to @question
    else
      flash[:warning] = "Failed to update question"
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:id])

    if @question.user == helpers.current_user && @question.destroy!
      flash[:success] = "Question deleted successfully"
      redirect_to questions_path
    else
      flash[:warning] = "Failed to delete question"
      redirect_to @question
    end
  end

  private

  def strong_params
    params.require(:question).permit(:question, :description, :topics)
  end
end

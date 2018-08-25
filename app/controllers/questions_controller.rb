class QuestionsController < ApplicationController
  before_action :authenticate_user!

  def search_topic
    @question = Question.find(params[:id])
    @results = Topic.search_by_name(params[:q]).where.not(id: @question.topics.pluck(:id))
    respond_to do |format|
      format.js {}
    end
  end

  def add_topic
    @question = Question.find(params[:id])
    topic = Topic.find(params[:topic_id])
    question_topic = QuestionTopic.new(question_id: @question.id, topic_id: topic.id)
    if question_topic.save
      flash[:success] = "Topic added successfully"
    else
      flash[:danger] = "Failed to add topic"
    end
    redirect_to @question
  end

  def remove_topic
    @question = Question.find(params[:id])
    topic = Topic.find(params[:topic_id])
    question_topic = QuestionTopic.where(question_id: @question.id, topic_id: topic.id)
    unless question_topic.empty?
      question_topic.delete_all
      flash[:success] = "Topic removed successfully"
    else
      flash[:danger] = "Failed to remove topic"
    end
    redirect_to @question
  end

  def new
    @question = Question.new
  end

  def edit
    @question = Question.find(params[:id])
  end

  def index
    @questions = Question.includes(:votes, :user, :topics, answers: [:user]).page(params[:page] || 1)
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
      redirect_back(fallback_location: root_path)
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

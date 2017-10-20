class TopicsController < ApplicationController
  def show
    @topic = Topic.find(params[:id])
  end

  def follow
    @topic = Topic.find(params[:topic_id])
    user = helpers.current_user
    follow = TopicUser.new(topic_id: @topic.id, user_id: user.id)
    if follow.save
      flash[:success] = "Topic followed successfully"
    else
      flash[:danger] = "Failed to follow topic"
    end
    redirect_to @topic
  end

  def unfollow
    @topic = Topic.find(params[:topic_id])
    user = helpers.current_user
    follows = TopicUser.where(topic_id: @topic.id, user_id: user.id)
    unless follows.empty?
      follows.delete_all
      flash[:success] = "Topic unfollowed successfully"
    else
      flash[:danger] = "Failed to unfollow topic"
    end
    redirect_to @topic
  end
end

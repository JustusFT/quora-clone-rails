class VotesController < ApplicationController
  def create
    @votable = find_votable
    @vote = @votable.votes.new(vote_params)
    @vote.user_id = helpers.current_user.id

    user_votes = Vote.where(user_id: helpers.current_user.id)

    if user_votes.exists?
      user_votes.first.destroy
    end

    @vote.save

    redirect_to @votable.get_question
  end

  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy

    redirect_to @vote.content.get_question
  end

  private

  def vote_params
    params.require(:vote).permit(:vote_type)
  end

  def find_votable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end

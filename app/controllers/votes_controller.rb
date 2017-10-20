class VotesController < ApplicationController
  def create
    @votable = find_votable
    @vote = @votable.votes.new(vote_params)
    @vote.user_id = helpers.current_user.id

    user_votes = @votable.votes.where(user_id: helpers.current_user.id)
    user_votes.first.destroy if user_votes.exists?

    if @vote.save
      flash[:success] = "#{@votable.class.name} #{@vote.vote_type}d successfully"
    else
      flash[:warning] = "Failed to #{@vote.vote_type} #{@votable.class.name.downcase}"
    end

    respond_to do |format|
      format.html { redirect_to @votable.get_question }
      format.js
    end
  end

  def destroy
    @vote = Vote.find(params[:id])
    @votable = @vote.content
    
    if @vote.destroy
      flash[:success] = "#{@vote.vote_type.capitalize} deleted successfully"
    else
      flash[:warning] = "Failed to delete #{@vote.vote_type}"
    end

    respond_to do |format|
      format.html { redirect_to @votable.get_question }
      format.js
    end
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

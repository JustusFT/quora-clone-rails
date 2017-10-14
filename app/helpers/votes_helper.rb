module VotesHelper
  def content_votes_url(content)
    method("#{content.class.name.downcase}_votes_url").call(content)
  end

  def current_vote(content)
    return nil if current_user.nil?
    content.votes.where(user_id: current_user.id).first
  end

  def has_vote?(content, type = "any")
    vote = current_vote(content)
    !vote.nil? && (vote.vote_type == type || type == "any")
  end
end

module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :content, dependent: :destroy
  end

  def upvotes
    self.votes.where(vote_type: "upvote")
  end

  def downvotes
    self.votes.where(vote_type: "downvote")
  end

  def score
    self.upvotes.count - self.downvotes.count
  end

  module ClassMethods

  end
end

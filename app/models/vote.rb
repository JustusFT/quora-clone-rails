class Vote < ApplicationRecord
  validates :user_id, presence: true
  validates :content_id, presence: true
  validates :content_type, presence: true
  validates :vote_type, presence: true
  validate :one_vote_per_item

  belongs_to :user
  belongs_to :content, polymorphic: true

  enum vote_type: [:upvote, :downvote]

  private
  def one_vote_per_item
    if(!self.content.nil? && self.content.votes.where(user_id: self.user_id).exists?)
      errors.add(:user, "can only vote once on an item")
    end
  end
end

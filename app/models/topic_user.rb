class TopicUser < ApplicationRecord
  validates_uniqueness_of :topic_id, scope: [:user_id]

  belongs_to :topic
  belongs_to :user
end

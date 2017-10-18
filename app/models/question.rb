class Question < ApplicationRecord
  include Votable

  validates :user_id, presence: true
  validates :question, presence: true, length: { maximum: 250 }

  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :question_topics
  has_many :topics, through: :question_topics

  default_scope { order(created_at: :desc) }
  scope :topic, ->(topic_id) { joins(:topics).where("topics": { id: topic_id }).group(:id) }

  paginates_per 5

  def get_question
    self
  end
end

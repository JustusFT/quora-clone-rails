class Topic < ApplicationRecord
  validates :name, presence: true

  has_many :topic_users
  has_many :users, through: :topic_users
  has_many :question_topics
  has_many :users, through: :question_topics

  include PgSearch
  pg_search_scope :search_by_name, against: :name, :using => {
    :tsearch => {:prefix => true}
  }
end

class Topic < ApplicationRecord
  validates :name, presence: true

  has_many :topic_users
  has_many :users, through: :topic_users
  has_and_belongs_to_many :questions
end

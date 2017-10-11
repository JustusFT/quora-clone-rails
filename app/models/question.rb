class Question < ApplicationRecord
  validates :user_id, presence: true
  validates :question, presence: true, length: { maximum: 250 }

  belongs_to :user
  has_many :answers
  has_many :votes, as: :content, dependent: :destroy
end

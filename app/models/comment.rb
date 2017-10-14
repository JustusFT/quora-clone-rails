class Comment < ApplicationRecord
  include Votable

  validates :user_id, presence: true
  validates :answer_id, presence: true
  validates :comment, length: { maximum: 65536 }

  belongs_to :user
  belongs_to :answer
  belongs_to :parent, class_name: "Comment", optional: true
  has_many :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy

  def get_question
    self.answer.question
  end
end

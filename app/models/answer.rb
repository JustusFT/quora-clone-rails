class Answer < ApplicationRecord
  validates :user_id, presence: true
  validates :question_id, presence: true
  validates :answer, presence: true, length: { maximum: 65536 }
  validate :one_answer_per_user
  before_create :one_answer_per_user

  belongs_to :user
  belongs_to :question

  def one_answer_per_user
    if self.new_record? && (self.question.nil? || self.question.answers.where(user_id: self.user_id).exists?)
      self.errors.add(:user, "can only answer once")
    end
  end
end

class CreateQuestionTopics < ActiveRecord::Migration[5.1]
  def change
    # rename previous join table so it can be used by the QuestionTopic model
    rename_table :questions_topics, :question_topics
    add_index :question_topics, [:question_id, :topic_id], unique: true
  end
end

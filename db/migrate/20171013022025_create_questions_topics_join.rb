class CreateQuestionsTopicsJoin < ActiveRecord::Migration[5.1]
  def change
    create_join_table :questions, :topics
  end
end

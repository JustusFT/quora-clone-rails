class CreateTopicUsers < ActiveRecord::Migration[5.1]
 def change
   rename_table :topics_users, :topic_users
   add_index :topic_users, [:topic_id, :user_id], unique: true
 end
end

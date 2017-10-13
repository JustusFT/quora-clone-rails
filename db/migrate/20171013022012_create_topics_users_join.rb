class CreateTopicsUsersJoin < ActiveRecord::Migration[5.1]
  def change
    create_join_table :topics, :users
  end
end

class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.integer :user_id, null: false
      t.integer :content_id, null: false
      t.string :content_type, null: false
      t.integer :vote_type, null: false
      t.timestamps
    end

    add_foreign_key :votes, :users
    add_index :votes, :user_id
    add_index :votes, [:content_type, :content_id]
  end
end

class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.integer :user_id, null: false
      t.integer :answer_id, null: false
      t.integer :parent_id
      t.text :comment, null: false, limit: 65536
      t.timestamps
    end

    add_foreign_key :comments, :users
    add_foreign_key :comments, :answers
    add_foreign_key :comments, :comments, column: :parent_id
    add_index :comments, :user_id
    add_index :comments, :answer_id
    add_index :comments, :parent_id
  end
end

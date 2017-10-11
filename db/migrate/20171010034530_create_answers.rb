class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.integer :user_id, null: false
      t.integer :question_id, null: false
      t.text :answer, null: false, limit: 65536
      t.timestamps
    end
    add_foreign_key :answers, :users
    add_foreign_key :answers, :questions
    add_index :answers, :user_id
    add_index :answers, :question_id
  end
end

class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.integer :user_id, null: false
      t.string :question, null: false, :limit => 250
      t.string :description
      t.timestamps
    end
    add_foreign_key :questions, :users
    add_index :questions, :user_id
  end
end

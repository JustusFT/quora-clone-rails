class AddFullNameToUsers < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.string :full_name, null: false
    end
  end
end

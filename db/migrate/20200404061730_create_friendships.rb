class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.references :user, null: false, index: true, foreign_key: true
      t.references :friend, null: false, index: true
      t.boolean :confirmed, default: false

      t.timestamps
    end
    add_foreign_key :friendships, :users, column: :friend_id
  end
end
class CreateFriends < ActiveRecord::Migration[6.0]
  def change
    create_table :friends do |t|
      t.integer :user_id
      t.integer :request_reciever_id

      t.timestamps
    end
  end
end

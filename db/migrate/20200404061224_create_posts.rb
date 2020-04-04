class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.references :profile, null: false, foreign_key: true
      t.text :original_message
      t.string :reference
      t.text :message

      t.timestamps
    end
  end
end

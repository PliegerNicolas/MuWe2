class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: true, foreign_key: true
      t.references :comment, null: true, foreign_key: true
      t.integer :rating, default: 0

      t.timestamps
    end
  end
end

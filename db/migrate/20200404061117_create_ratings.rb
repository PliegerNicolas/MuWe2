class CreateRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :ratings do |t|
      t.references :participant, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :rating, default: 0

      t.timestamps
    end
  end
end

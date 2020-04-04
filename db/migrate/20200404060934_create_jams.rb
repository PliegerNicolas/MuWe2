class CreateJams < ActiveRecord::Migration[6.0]
  def change
    create_table :jams do |t|
      t.references :user, null: false, foreign_key: true
      t.references :music_style, null: false, foreign_key: true
      t.text :description
      t.integer :max_participants
      t.integer :status, default: 0
      t.datetime :start_date_time
      t.integer :duration
      t.boolean :privacy, default: false

      t.timestamps
    end
  end
end
